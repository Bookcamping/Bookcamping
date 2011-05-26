# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Controllers::AuthMethods

  expose(:current_camp) do
    if request.subdomain.present?
      camp = Camp.find_by_subdomain(request.subdomain)
      session[:camp_id] ||= camp.id if camp
    end
    session[:camp_id] ||= 1
    Camp.find session[:camp_id]
  end

  helper_method :current_user, :current_user?


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
