# encoding: utf-8
class References::ShelfItemsController < ApplicationController
  respond_to :html

  expose(:book) { Book.find params[:book_id] }
  expose(:parent) { book }
  expose(:shelf_items) { parent.shelf_items }
  expose(:shelf_item)

  def index

  end

  def create
    shelf = Shelf.find params[:shelf_item][:shelf_id]
    authorize! :manage, shelf
    item = ShelfItem.new(shelf: shelf, book: book, user: current_user, camp: current_camp)
    unless book.shelves.include? shelf
      flash[:notice] = "#{book.title} añadida a '#{item.shelf.name}'" if item.save
    end
    respond_with item, location: [book, :shelf_items]
  end

  def destroy
    authorize! :manage, shelf_item.shelf
    flash[:notice] = "#{shelf_item.book} quitado de '#{shelf_item.shelf.name}" if shelf_item.destroy
    respond_with shelf_item, location: [book, :shelf_items]
  end
end

