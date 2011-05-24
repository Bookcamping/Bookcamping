# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

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

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
