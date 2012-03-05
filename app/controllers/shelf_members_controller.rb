# encoding: utf-8
class ShelfMembersController < ApplicationController
  before_filter :require_user
  respond_to :html

  expose(:shelf) { UserShelf.find params[:user_shelf_id] }
  expose(:search) { Search.new(:users, User.reorder('last_login_at DESC'), params[:user_name]) }
  expose(:user) { User.find params[:user_id]}

  expose_resource :shelf_member
  expose(:shelf_members) { shelf.shelf_members }

  def index
    index!
  end

  def new
    authorize! :update, shelf
  end

  def create
    authorize! :update, shelf
    ShelfMember.create!(shelf_id: shelf.id, user_id: user.id)
    redirect_to shelf, notice: '¡Colaboradora añadida!'
  end

  def destroy
    destroy!
  end
end