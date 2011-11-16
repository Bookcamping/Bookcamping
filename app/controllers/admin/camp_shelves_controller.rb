# encoding: utf-8
class Admin::CampShelvesController < Admin::ShelvesController
  expose(:camp_shelves) { current_camp.camp_shelves }
  expose(:camp_shelf )

  # ALIASES
  expose(:shelves) { camp_shelves }
  expose(:shelf) { camp_shelf }

  def create
    shelf.user_id = 284
    shelf.camp = current_camp
    flash[:notice] = 'Estantería creada ¡A trabajar!' if shelf.save
    respond_with shelf, location: [:admin, shelf]
  end
end
