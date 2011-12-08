# encoding: utf-8
# Permite cambiar la contraseña.
class Public::PasswordRecoveriesController < ApplicationController
  respond_to :html

  expose(:password_recovery)
  expose(:identity) { Identity.find_by_provider_and_uid!('recovery',  params[:id]) }

  # Formulario para poner tu email
  def new
  end

  # Muestra el mensaje de que se te ha enviado un email (en caso
  # de que se haya encontrado ese email entre lxs usuarixs)
  def show
  end

  # Crea el PasswordRecovery y muestra el resultado (mediante show)
  def create
    password_recovery.save
    respond_with password_recovery
  end

  # Muestra el formulario para cambiar de contraseña
  def recover
  end

  # La acción del formulario para cambiar de contraseña
  def change
    user = User.find params[:user_id]
    if params[:password].present?
      user.identify_with(params[:password])
      flash[:notice] = 'Contraseña modificada'
      user.destroy_recovery_identity
      redirect_to login_path
    else
      redirect_to change_password_recoveries_path(identity.ui), notice: 'Tienes que poner algo en la contraseña'
    end
  end


end

