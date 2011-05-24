class BookListsController < ApplicationController
  respond_to :html, :js
  expose(:book_lists) { BookList.all }
  expose(:book_list)

  def show_all

  end

  def index
  end

  def show
  end

  def edit
    authorize! :edit, book_list
  end
  
  def update
    authorize! :update, book_list
    flash[:notice] = "Lista modificada." if book_list.update_attributes(params[:book_list])
    respond_with book_list
  end

end
