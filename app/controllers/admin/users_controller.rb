class Admin::UsersController < Admin::ApplicationController
  respond_to :html
  expose(:users) { User.order('updated_at DESC').limit(10)}
  expose(:user) { users.find_by_slug params[:id] }

  def index

  end

  def destroy
    if Rails.env.development?
      user.shelves.each {|s| s.destroy}
      user.shelves = []
      user.destroy
    end
    redirect_to admin_users_path
  end
end
