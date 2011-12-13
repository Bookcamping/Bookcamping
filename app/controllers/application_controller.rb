# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery

  include Extensions::RequireUser
  include Extensions::LoadCamp
  include Extensions::ExposeWithSlug
  include Extensions::ExposeResource

  helper_method :current_user, :current_user?

  expose(:current_camp) { load_camp_from_request }
  # Current publisher: used to change the layout
  expose(:current_publisher) { nil }

  def info_for_paper_trail
    { user_name: (current_user? ? current_user.name : 'Anónimx') }
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
