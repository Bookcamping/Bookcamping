# Controller for CampShelf models
class Library::CampShelvesController < ApplicationController

  expose_with_slug

  expose(:on_member?) { params[:id].present? }
  expose(:current_camp) { on_member? ? camp_shelf.camp : load_camp_from_request }
  expose(:parent) { on_member? ? Site.new : current_camp }
  expose(:shelf_order) { Shelf::Order.new(params[:o]) }
  expose(:camp_shelves) { shelf_order.order(parent.camp_shelves(include: [:camp])) }
  expose(:camp_shelf)


  def show

  end

  def new
    authorize! :manage, CampShelf
  end

end
