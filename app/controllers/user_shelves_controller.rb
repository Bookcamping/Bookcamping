class UserShelvesController < ApplicationController
  before_filter :require_user, except: [:index, :show]
  respond_to :html

  expose_resource :user_shelf
  delegate_resource :shelf, to: :user_shelf

  expose(:parent) { current_user || Site.new }
  expose(:user_shelves) { parent.visible_user_shelves.order('updated_at DESC') }
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

  def destroy
    destroy!
  end
end
