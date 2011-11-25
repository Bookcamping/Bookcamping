# encoding: utf-8
class Public::PasswordRecoveriesController < ApplicationController
  respond_to :html
  expose(:password_recovery)
  expose(:identity) { Identity.find_by_provider_and_uid! 'recovery',  params[:id] }
  def new
  end

  def show
  end

  def create
    password_recovery.save
    respond_with password_recovery
  end

  def recover
  end

  def change
    user = User.find params[:user_id]
    if params[:password].present?
      user.identify_with(params[:password])
      flash[:notice] = 'Contraseña modificada'
      redirect_to login_path
    else
      redirect_to change_password_recoveries_path(identity.ui), notice: 'Tienes que poner algo en la contraseña'
    end
  end


end

