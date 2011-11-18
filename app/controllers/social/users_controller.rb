class Social::UsersController < ApplicationController
  respond_to :html
  expose(:users) { User.order('login_count DESC').limit(100) }
  expose(:user)
  expose(:shelf_order) { Shelf::Order.new(params[:o]) }
  expose(:shelves) { shelf_order.order user.shelves.public }

  def index
  end

  def show
  end
end

