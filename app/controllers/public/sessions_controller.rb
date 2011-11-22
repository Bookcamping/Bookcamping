# encoding: utf-8
class Public::SessionsController < ApplicationController

  expose(:redirect_url) { params[:from].present? ? params[:from] : '/'}
  expose(:omniauth) { request.env['omniauth.auth'] }

  def new
    if current_user?
      redirect_to personal_user_path
    else
      store_location(params[:from]) if params[:from].present?
      redirect_to "/auth/#{params[:id]}" if params[:id].present?
    end
  end


  def create_with_omniauth
    identity = Identity.identify_omniauth(omniauth)
    if identity
      login_user(identity.user) 
    else
      user = User.new do |user|
        user.name = omniauth['info']['name']
        user.email = omniauth['info']['email']
        user.twitter = omniauth['info']['nickname']
      end
      user.save!
      login_user(user)
    end
  end

  def create
    data = params[:user]
    identity = Identity.identify_credentials(data[:email], data[:password])
    if identity
      login_user(identity.user)
    else
      redirect_to login_path, notice: 'No te hemos encontrado.'
    end
  end

  def destroy
    store_location(params[:from]) if params[:from]
    clear_user
    redirect_to stored_or(root_url), :notice => t('sessions.signed_out')
  end

  def enter
    if not Rails.env.production? or (current_user and current_user.super?)
      self.current_user = User.find params[:id]
    end
    redirect_to stored_or(root_path)
  end

  def failure
    redirect_to login_path, notice: 'No se te ha podido identificar. Inténtalo de nuevo.'
  end

  protected
  def login_user(user)
    self.current_user = user
    user.last_login_at = Time.now
    user.login_count ||= 0
    user.login_count = user.login_count + 1
    user.save(:validate => false)
    redirect_to stored_or(root_path), notice:
      "¡Hola #{user.name}!"
  end
end
