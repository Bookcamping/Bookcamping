class BooksController < ApplicationController
  respond_to :js
  expose(:books)
  expose(:book)

  def show

  end

  def edit
  end

  def update
    book.update_attributes(params[:book])
    respond_with book, :location => root_path
  end
end
