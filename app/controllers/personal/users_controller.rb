class Personal::UsersController < User::ApplicationController
  respond_to :html, :json
  expose(:user) { current_user }

  def show
    respond_with user
  end

  def edit
    respond_with user
  end

  def update
    respond_with user, location: [:personal, user]
  end
end

