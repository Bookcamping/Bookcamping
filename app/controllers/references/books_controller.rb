class References::BooksController < Shared::BooksController

  expose(:search_results) { RefSearch.new(current_camp.books).search(params[:term]) }
  expose(:current_camp) { params[:id].present? ? book.camp : load_camp_from_request }

  def show

  end

  def search

  end
end

