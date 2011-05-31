class UsersController < ApplicationController
  respond_to :html
  expose(:users) { current_camp.users }
  expose(:user)
  expose(:books) { user.books.where(:camp_id => current_camp.id) }

  def index
  end

  def show
  end

  def edit
    authorize! :edit, user
  end

  def update
    authorize! :update, user
    flash[:notice] = t('users.notice.update') if user.update_attributes(params[:user])
    respond_with user
  end
end
