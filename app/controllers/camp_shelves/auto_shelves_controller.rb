class CampShelves::AutoShelvesController < ApplicationController

  expose(:auto_shelf) { AutoShelf.find(params[:id], current_camp) }


  def show

  end

end
