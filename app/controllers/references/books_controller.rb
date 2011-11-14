class References::BooksController < Shared::BooksController
  expose(:search_results) { RefSearch.new(current_camp.books).search(params[:term]) }
  expose(:shelf) { current_camp }

  def show

  end

  def search

  end
end

