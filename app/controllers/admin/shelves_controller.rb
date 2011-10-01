class Admin::ShelvesController < Admin::ApplicationController
  respond_to :html, :json
  expose(:shelves) { current_camp.shelves }
  expose(:shelf)

  def show

  end


  def create
    shelf.user = current_user
    shelf.camp = current_camp
    flash[:notice] = t('.create') if shelf.save
    respond_with shelf
  end
end