class Social::UserShelvesController < ApplicationController
  respond_to :html

  expose_with_slug
  expose(:user) { User.find params[:user_id] } 
  expose(:shelves) { user.user_shelves.public }
  expose(:shelf)

  def index
    authorize! :read, user
  end
  
  def show
    authorize! :show, shelf
  end
end

