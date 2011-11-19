class Social::UserShelvesController < ApplicationController
  respond_to :html

  expose_with_slug
  expose(:user) { User.find_by_slug params[:user_id]  }
  expose(:shelves) { user.user_shelves.public }
  expose(:shelf)

  def show
  end
end

