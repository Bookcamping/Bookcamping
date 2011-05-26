class ShelfItemsController < ApplicationController
  respond_to :html, :json
  autocomplete :book, :title, :full => true

  expose(:book) { current_camp.books.find params[:book_id] }
  expose(:shelf_item)

  def new
  end

  def create
    authorize! :create, ShelfItem
    unless book.shelves.include? shelf_item.shelf
      shelf_item.book = book
      shelf_item.user = current_user
      flash[:notice] = t('shelf_items.notice.create') if shelf_item.save
    end
    respond_with :shelf_item, :location => book
  end

  def destroy
    flash[:notice] = t('shelf_items.notice.destroy') if shelf_item.destroy
    respond_with :shelf_item, :location => book
  end
end
