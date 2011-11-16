class Social::UsersController < ApplicationController
  respond_to :html
  expose(:users) { User.order('login_count DESC').limit(100) }
  expose(:user)
  expose(:shelves) { user.public_shelves }

  def index
  end

  def show
  end
end

