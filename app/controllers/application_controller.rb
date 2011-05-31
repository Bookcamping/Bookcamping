# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Controllers::AuthMethods
  helper_method :current_user, :current_user?

  expose(:current_camp) do
    if request.subdomain.present?
      camp = Camp.find_by_subdomain(request.subdomain)
      session[:camp_id] ||= camp.id if camp
    end
    session[:camp_id] ||= 1
    Camp.find session[:camp_id]
  end

  def render_grid(name, books)
    render :partial => 'books/list_as_grid', :locals => {:name => name, :books => books}
  end


  def info_for_paper_trail
    {:user_name => current_user? ? current_user.name : 'Anónimx',
     :camp_id => current_camp.id}
  end


  rescue_from ActionView::TemplateError do |x|
    #bubble up the original exception
    #ActiveRecord::RecordNotFound
    raise x.original_exception
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_url, :notice => t('access_denied.no_privilegies')
    else
      redirect_to root_url, :notice => t('access_denied.no_user')
    end
  end
end
