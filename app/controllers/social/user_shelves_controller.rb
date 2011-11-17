class Social::UserShelvesController < ApplicationController
  respond_to :html
  expose(:user) { User.find params[:user_id]  }
  expose(:shelves) { user.user_shelves.public }
  expose(:shelf)

  def show
  end
end

