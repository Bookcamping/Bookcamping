class Social::UsersController < ApplicationController
  respond_to :html

  expose_with_slug
  expose(:users) { User.order('login_count DESC').limit(100) }
  expose(:user)
  expose(:shelf_order) { Shelf::Order.new(params[:o]) }
  expose(:shelves) { shelf_order.order user.shelves.public }

  expose(:search) { Search.new(:users, users, params[:term]) }

  def index
  end


  def show
  end
end

