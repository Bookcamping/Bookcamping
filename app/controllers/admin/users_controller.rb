class Admin::UsersController < Admin::ApplicationController
  respond_to :html

  expose_with_slug 
  expose(:users) { User.order('updated_at DESC').limit(10)}
  expose(:user)

  def index
  end

  def create
    user.save
    user.identify_with('entrar')
    respond_with user
  end

  def update
    user.save
    respond_with user
  end

  def destroy
      user.shelves.each {|s| s.destroy}
      user.shelves = []
      user.destroy
    redirect_to admin_users_path
  end
end
