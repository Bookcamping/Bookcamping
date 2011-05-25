class BooksController < ApplicationController
  respond_to :html, :js
  expose(:shelves) { Shelf.all }
  expose(:shelf) { Shelf.find params[:shelf_id] if params[:shelf_id]}
  expose(:books)
  expose(:book)

  def show
  end

  def new
  end

  def edit
  end

  def create
    book.user = current_user
    Book.transaction do
      flash[:notice] = t('books.notice.create') if book.save
      shelf.add_book book, current_user
    end
    respond_with book
  end

  def update
    rol = current_user.rol ? current_user.rol.to_sym : nil
    book.update_attributes(params[:book], :as => rol)
    respond_with book
  end

  def destroy
    authorize! :destroy, book
    book.destroy
    respond_with book, :location => root_path
  end
end
