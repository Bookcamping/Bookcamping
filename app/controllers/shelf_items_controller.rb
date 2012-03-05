class ShelfItemsController < ApplicationController
  before_filter :require_user

  expose(:shelf) { find_shelf }
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

  protected
  def find_shelf
    if params[:camp_shelf_id].present?
      CampShelf.find_by_slug!(params[:camp_shelf_id])
    elsif params[:user_shelf_id].present?
      UserShelf.find(params[:user_shelf_id])
    end
  end
end