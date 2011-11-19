class References::BooksController < Shared::BooksController

  expose(:search) { Search.new(:books, current_camp.books, params[:term]) }
  expose(:current_camp) { params[:id].present? ? book.camp : load_camp_from_request }

  def show
  end


end

