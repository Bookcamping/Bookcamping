# Controller for Books belonging to CampShelves
class Library::BooksController < Shared::BooksController
  expose(:camp_shelf) { CampShelf.find_by_slug(params[:camp_shelf_id]) || CampShelf.find(params[:camp_shelf_id]) }
  expose(:shelf) { camp_shelf }
  expose(:pajax?) { request.headers['X-PJAX'].present? }
  expose(:current_camp) { camp_shelf.camp }
  
  def show
    if pajax?
      render action: 'show_pjax', layout: false
    end
  end

end

