# Controller for Books belonging to CampShelves
class Library::BooksController < Shared::BooksController
  expose(:camp_shelf) { current_camp.camp_shelves.find params[:camp_shelf_id] }
  expose(:shelf) { camp_shelf }
  expose(:pajax?) { request.headers['X-PJAX'].present? }

  def show
    if pajax?
      render action: 'show_pjax', layout: false
    end
  end

end

