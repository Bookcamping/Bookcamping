# encoding: utf-8
# Controller for CampShelf models
class CampShelvesController < ApplicationController
  respond_to :html
  expose_with_slug

  expose(:on_member?) { params[:id].present? }
  expose(:current_camp) { on_member? ? camp_shelf.camp : load_camp_from_request }
  expose(:parent) { on_member? ? Site.new : current_camp }
  expose(:shelf_order) { Shelf::Order.new(params[:o]) }
  expose_resource :camp_shelf
  expose(:camp_shelves) { shelf_order.order(parent.camp_shelves) }

  def index
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
    if current_camp.lock_camp_shelves? && !current_user.admin?
      redirect_to camp_shelves_path, notice: 'No se pueden crear estanterías'
    else
      camp_shelf.user = current_user
      camp_shelf.camp = current_camp
      camp_shelf.visibility = :public
      create! [camp_shelf]
    end
  end

  def update
    update! [camp_shelf]
  end

end