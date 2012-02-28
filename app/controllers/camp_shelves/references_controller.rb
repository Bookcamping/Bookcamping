# Controller for Books belonging to CampShelves
class CampShelves::ReferencesController < Shared::ReferencesController
  expose(:camp_shelf) { CampShelf.find_by_slug(params[:camp_shelf_id]) || CampShelf.find(params[:camp_shelf_id]) }
  expose(:shelf) { camp_shelf }
  expose(:current_camp) { shelf.camp }

  def show
    if pajax?
      render action: 'show_pjax', layout: false
    end
  end

  def new
    reference.include_in_shelf_id = camp_shelf.id
    reference.title = params[:title]
  end



end

