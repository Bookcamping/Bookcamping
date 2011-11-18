# Controller for CampShelf models
class Library::CampShelvesController < ApplicationController
  expose(:camp_shelves) { ordered(current_camp.camp_shelves) }
  expose(:shelves_order) { ORDERS.include?(params[:o]) ? params[:o] : ORDERS[0] }
  expose(:camp_shelf)

  ORDERS = ['activas', 'alfabetico', 'original']

  def index

  end

  def show

  end

  def new
    authorize! :manage, CampShelf
  end

  protected
  def ordered(collection)
    if shelves_order == 'alfabetico'
      collection.order('name ASC')
    elsif shelves_order == 'original'
      collection.order('id ASC')
    elsif shelves_order == 'activas'
      collection.order('updated_at DESC')
    end
  end
end
