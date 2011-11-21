class Social::UserShelvesController < ApplicationController
  respond_to :html

  expose(:user) { User.find_by_slug(params[:user_id]) || User.find(params[:user_id]) }
  expose(:user)
  expose(:shelves) { user.user_shelves.public }
  expose(:shelf)

  def show
  end
end

