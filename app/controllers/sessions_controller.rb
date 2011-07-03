class SessionsController < ApplicationController

  def new
    store_location(params[:from]) if params[:from]
    redirect_to "/auth/#{params[:id]}"
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user.membership(current_camp)
    user.last_login_at = Time.now
    user.login_count ||= 0
    user.login_count = user.login_count + 1
    user.save(:validate => false)
    session[:user_id] = user.id
    redirect_to stored_or(root_url), :notice => t('sessions.signed_in')
  end

  def destroy
    store_location(params[:from]) if params[:from]
    clear_user
    redirect_to stored_or(root_url), :notice => t('sessions.signed_out')
  end

  def enter
    if Rails.env.development? or (current_user and current_user.super?)
      self.current_user = User.find params[:id]
    end
    redirect_to stored_or(root_path)
  end
end
