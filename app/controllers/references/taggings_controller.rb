class References::TaggingsController < ApplicationController
  expose(:book) { Book.find params[:book_id] }
  
  def create
    authorize! :create, Tagging
    current_user.add_tag(book, params[:tag_name])
    redirect_to book
  end

  def destroy
    authorize! :destroy, Tagging
    tagging = book.taggings.find params[:id]
    tagging.destroy
    redirect_to book
  end
end
