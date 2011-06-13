class AutoShelvesController < ApplicationController
  respond_to :html

  expose(:auto_shelf) { AutoShelf.find(params[:id], current_camp) }

  def show

  end

end
