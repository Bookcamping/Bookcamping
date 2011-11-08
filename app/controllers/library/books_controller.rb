# Controller for Books belonging to CampShelves
class Library::BooksController < Shared::BooksController
  expose(:camp_shelf) { current_camp.camp_shelves.find params[:camp_shelf_id] }
  expose(:book) { camp_shelf.books.find params[:id] }
  expose(:shelf) { camp_shelf }

  def show

  end
end

