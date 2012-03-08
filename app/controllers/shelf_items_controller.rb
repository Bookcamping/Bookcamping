class ShelfItemsController < ApplicationController
  before_filter :require_user
  respond_to :html

  expose(:shelf) { find_parent_shelf }
  expose(:search) { Search.new(:references, Reference.order('title ASC'), params[:title]) }
  expose(:reference) { Reference.find params[:reference_id]}

  expose_resource :shelf_item
  expose(:shelf_items) { shelf.shelf_items }

  def edit
    edit!
  end

  def new
    authorize! :add_to, shelf
  end

  def create
    authorize! :add_to, shelf
    shelf.add_reference(reference, current_user)
    redirect_to shelf
  end

  def update
    update! [shelf, shelf_item.reference]
  end

end
