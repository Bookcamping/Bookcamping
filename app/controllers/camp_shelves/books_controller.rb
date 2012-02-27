# Controller for Books belonging to CampShelves
class CampShelves::BooksController < Shared::BooksController
  expose(:camp_shelf) { CampShelf.find_by_slug(params[:camp_shelf_id]) || CampShelf.find(params[:camp_shelf_id]) }
  expose(:shelf) { camp_shelf }
  expose(:current_camp) { shelf.camp }

  def show
    if pajax?
      render action: 'show_pjax', layout: false
    end
  end

  def new
    book.include_in_shelf_id = camp_shelf.id
    book.title = params[:title]
  end



end

