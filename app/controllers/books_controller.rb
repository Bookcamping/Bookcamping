class BooksController < ApplicationController
  respond_to :html, :js
  expose(:book_lists) { BookList.all }
  expose(:books)
  expose(:book)

  def show
  end

  def new
    book.book_list_id = params[:book_list_id]
  end

  def edit
  end

  def create
    book.user = current_user
    flash[:notice] = t('books.notice.create') if book.save
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
    respond_with book
  end
end
