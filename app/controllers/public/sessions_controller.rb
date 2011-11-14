# encoding: utf-8
class Public::SessionsController < ApplicationController

  expose(:redirect_url) { params[:from].present? ? params[:from] : '/'}

  def new
    if current_user?
      redirect_to personal_user_path
    else
      store_location(params[:from]) if params[:from].present?
      redirect_to "/auth/#{params[:id]}" if params[:id].present?
    end
  end

  def create
    session = User::Session.new(params[:user]) if params[:user].present?
    session ||= User::Session.new(request.env["omniauth.auth"])
    if session.create
      self.current_user = session.user
      User::MembershipSetup.new(current_camp, current_user).setup_membership
      redirect_to stored_or(root_url), notice: "¡Hola #{current_user.name}!"
    else
      redirect_to login_path, notice: '¡No te hemos encontrado o la contraseña es incorrecta! Inténtalo de nuevo.'
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
    redirect_to login_path(notice: 'No se te ha podido identificar. Inténtalo de nuevo.')
  end
end
