class Personal::BooksController < Personal::ApplicationController
  expose(:references) { current_user.references.where(camp_id: current_camp.id) }
  expose(:reference)

  def index

  end
end

