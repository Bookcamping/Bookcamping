class BooksController < ApplicationController
  respond_to :html, :js, :json
  expose(:shelves) { current_camp.shelves }
  expose(:shelf) { shelves.find params[:shelf_id] if params[:shelf_id]}
  expose(:books) { current_camp.books }
  expose(:book)
  expose(:search_results) { current_camp.books.search params[:term] }

  def search
  end
  
  def view
    render :layout => false
  end

  def show
    respond_with :book
  end

  def new
    authorize! :new, book
  end

  def edit
    authorize! :edit, book
  end

  def create
    book.user = current_user
    book.camp = current_camp
    authorize! :create, book
    Book.transaction do
      flash[:notice] = t('books.notice.create') if book.save
      shelf.add_book book, current_user
    end
    respond_with book
  end

  def update
    authorize! :update, book
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
