# encoding: utf-8
class Personal::UsersController < Personal::ApplicationController
  before_filter :require_user, except: [:new, :create]
  respond_to :html, :json
  expose(:user) { current_user ? current_user : User.new(params[:user]) }

  def show
  end

  def edit
  end

  def new
  end

  def create
    if user.save
      flash[:notice] = 'Bienvenida a #bookcamping'
      SetupUser.new(user).create_profile_shelves if new_user?
      self.current_user = user
    end
    respond_with user, location: personal_user_path
  end

  def update
    authorize! :edit, user
    flash[:notice] = 'Tus datos han sido actualizados. ¡Gracias!' if user.update_attributes(params[:user])
    respond_with user, location: personal_user_path
  end
end

