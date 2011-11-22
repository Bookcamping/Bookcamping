# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Controllers::AuthMethods
  helper_method :current_user, :current_user?

  expose(:current_camp) { load_camp_from_request }
  expose(:current_publisher) { nil }

  def info_for_paper_trail
    {:user_name => current_user? ? current_user.name : 'Anónimx',
     :camp_id => current_camp.id}
  end

  def self.expose_with_slug
    default_exposure do |name|
      collection = name.to_s.pluralize
      if respond_to?(collection) && collection != name.to_s && send(collection).respond_to?(:scoped)
        proxy = send(collection)
      else
        proxy = name.to_s.classify.constantize
      end

      if params.has_key?(:id)
        shelf = proxy.find_by_slug(params[:id])
        shelf ||= proxy.find(params[:id])
        shelf.tap do |r|
          r.attributes = params[name] unless request.get?
        end
      else
        proxy.new(params[name])
      end
    end
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

  protected
  def load_camp_from_request
    if request.domain == 'videocamping.cc'
      session[:camp_id] = 2
    elsif request.subdomain.present? and (request.subdomain == 'escucha' or request.subdomain == 'escuchamos')
      session[:camp_id] = 3
    end
    session[:camp_id] ||= 1
    Camp.find session[:camp_id]
  end
end
