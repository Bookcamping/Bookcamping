# Controller for CampShelf models
class Library::CampShelvesController < ApplicationController
  expose(:camp_shelves) { current_camp.camp_shelves }
  expose(:camp_shelf)

  def index

  end

  def show

  end

  def new
    authorize! :manage, CampShelf
  end
end
