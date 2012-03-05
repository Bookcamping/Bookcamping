class ShelfItemsController < ApplicationController
  before_filter :require_user

  expose(:shelf) { find_parent_shelf }
  expose(:search) { Search.new(:references, Reference.order('title ASC'), params[:title]) }
  expose(:reference) { Reference.find params[:reference_id]}

  def new
    authorize! :update, shelf
  end

  def create
    authorize! :update, shelf
    shelf.add_reference(reference, current_user)
    redirect_to shelf
  end

end