# Controller for CampShelf models
class Library::CampShelvesController < ApplicationController
  expose(:current_camp) { params[:id].present? ? camp_shelf.camp : load_camp_from_request }
  expose(:site) { Site.new }
  expose(:shelf_order) { Shelf::Order.new(params[:o]) }
  expose(:camp_shelves) { shelf_order.order(site.camp_shelves) }
  expose(:camp_shelf)

  def index

  end

  def show

  end

  def new
    authorize! :manage, CampShelf
  end

end
