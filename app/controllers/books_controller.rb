class BooksController < ApplicationController
  respond_to :js
  expose(:books)
  expose(:book)

  def show
  end

  def new
    book.book_list_id = params[:list]
  end

  def edit
  end

  def create
    book.save
    respond_with book, :location => root_path
  end

  def update
    book.update_attributes(params[:book])
    respond_with book, :location => root_path
  end
end
