class Backend::UsersController < Backend::ResourceController

  def show
    load_user
    show! 
  end

  def edit
    load_user
    edit!
  end

  def load_user
    @user = User.find_by_slug params[:id]
  end
end

