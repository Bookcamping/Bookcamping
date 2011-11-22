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

  def create
    identity = nil
    data = params[:user]
    if data.present?
      identity = Identity.identify_credentials(data[:email], data[:password])
    elsif omniauth
      identity = Identity.identify_omniauth(omniauth)
    end

    if identity.present? # Usuario encontrado
      puts identity.inspect
      self.current_user = identity.user
      audit_user(current_user)
      redirect_to stored_or(root_url), notice: "¡Hola #{current_user.name}!"
    elsif omniauth # Nuevo usuario con omniauth
      user = User::SetupUser.create_from_omniauth(omniauth)
      if user.persisted?
        self.current_user = user
        audit_user(current_user)
       # redirect_to edit_personal_user_path, notice: 'Por favor, completa tus datos.'
       redirect_to stored_or(root_url), notice: "¡Hola #{current_user.name}!"
      else  
        @user = user
        render 'edit'
      end
    else # Usuario no encontrado
      redirect_to login_path, notice: '¡No te hemos encontrado! ¿Segura que estás dada de alta?'
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
  def audit_user(user)
    user.last_login_at = Time.now
    user.login_count ||= 0
    user.login_count = user.login_count + 1
    user.save(:validate => false)
  end

  def add_missing_info(omniauth, user)
    if user.twitter.blank? and omniauth['provider'] == 'twitter'
      user.twitter = omniauth['info']['nickname']
    end
    if user.email.blank? and omniauth['user_info']['email'].present?
      user.email = omniauth['info']['email']
    end
  end
  
  
  
end
