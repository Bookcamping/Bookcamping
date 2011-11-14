# Controller for Books belonging to CampShelves
class Library::BooksController < Shared::BooksController
  expose(:camp_shelf) { current_camp.camp_shelves.find params[:camp_shelf_id] }
  expose(:shelf) { camp_shelf }

  def show
    if request.headers['X-PJAX']
      render action: 'show_pjax', layout: false
    end
  end

end

