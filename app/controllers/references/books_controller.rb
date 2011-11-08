class References::BooksController < Shared::BooksController
  expose(:search_results) { RefSearch.new(current_camp.books).search(params[:term]) }

  def show

  end

  def search

  end
end

