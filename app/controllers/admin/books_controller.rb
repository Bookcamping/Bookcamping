class Admin::BooksController < Admin::ApplicationController
  expose(:books) { current_camp.books }
  expose(:page) { params[:page].present? ? params[:page] : 1 }
  expose(:results) { books.order('updated_at DESC').page(page) }


  def index

  end
end