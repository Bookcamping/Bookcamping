# encoding: utf-8
class Personal::UsersController < Personal::ApplicationController
  respond_to :html, :json
  expose(:user) { current_user }

  def show
    respond_with user
  end

  def edit
    respond_with user
  end

  def update
    authorize! :edit, user
    flash[:notice] = 'Tus datos han sido actualizados. ¡Gracias!' if user.update_attributes(params[:user])
    respond_with user, location: personal_user_path
  end
end

