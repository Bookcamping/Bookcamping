# encoding: utf-8
class ShelfMembersController < ApplicationController
  expose(:shelf) { UserShelf.find params[:user_shelf_id] }
  expose(:search) { Search.new(:users, User.reorder('updated_at DESC'), params[:user_name]) }
  expose(:user) { User.find params[:user_id]}

  def new
    authorize! :manage, shelf
  end

  def create
    authorize! :manage, shelf
    ShelfMember.create!(shelf_id: shelf.id, user_id: user.id)
    redirect_to shelf, notice: '¡Colaboradora añadida!'
  end
end