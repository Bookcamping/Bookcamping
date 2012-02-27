class UserShelvesController < ApplicationController
  before_filter :require_user, except: [:index, :show]
  respond_to :html

  expose_resource :user_shelf
  expose(:user_shelves) { UserShelf.where(rol: nil) }
  expose(:user_shelf)

  def index
    index!
  end

  def show
    show!
  end

  def new
    new!
  end

  def edit
    edit!
  end

  def create
    user_shelf.user = current_user
    create!
  end

  def update
    update!
  end
end
