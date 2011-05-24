class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => t('sessions.signed_in')
  end

  def destroy
    clear_user
    redirect_to root_url, :notice => t('sessions.signed_out')
  end

  def enter
    if Rails.env.development? or (current_user and current_user.super?)
      self.current_user = User.find params[:id]
    end
    redirect_to root_path
  end
end
