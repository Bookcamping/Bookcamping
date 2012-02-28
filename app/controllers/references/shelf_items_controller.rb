# encoding: utf-8
#
# Gestionar listas de una referencia
#
class References::ShelfItemsController < ApplicationController
  respond_to :html
  before_filter :require_user

  expose(:reference) { Reference.find params[:reference_id] }
  expose(:reference_shelves) { reference.shelves }
  expose(:parent) { reference }
  expose(:shelf_items) { parent.shelf_items }
  expose(:shelf_item)

  def index

  end

  def create
    shelf = Shelf.find params[:shelf_item][:shelf_id]
    authorize! :manage, shelf
    item = ShelfItem.new(shelf: shelf, reference: reference, user: current_user, camp: current_camp)
    unless reference.shelves.include? shelf
      flash[:notice] = "#{reference.title} añadida a '#{item.shelf.name}'" if item.save
    end
    respond_with item, location: [reference, :shelf_items]
  end

  def destroy
    authorize! :manage, shelf_item.shelf
    flash[:notice] = "#{shelf_item.reference} quitado de '#{shelf_item.shelf.name}" if shelf_item.destroy
    respond_with shelf_item, location: [reference, :shelf_items]
  end
end

