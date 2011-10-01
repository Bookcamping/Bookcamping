class Personal::BooksController < Personal::ApplicationController
  expose(:books) { current_user.books.where(camp_id: current_camp.id) }
  expose(:book)

  def index

  end
end

