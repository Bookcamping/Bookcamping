class References::TagsController < ApplicationController
  expose(:book) { Book.find params[:book_id] }
  
  def create
    current_user.tag(book, with: params[:tags], on: :tags)
    redirect_to book
  end
end
