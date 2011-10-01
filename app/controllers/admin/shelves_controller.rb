class Admin::ShelvesController < Admin::ApplicationController
  respond_to :html, :json
  expose(:shelves) { current_camp.shelves }
  expose(:shelf)

  def index
    respond_with shelves
  end

  def show
    respond_with shelf
  end

  def edit
    respond_with shelf
  end

  def create
    shelf.user = current_user if shelf.user_id.blank?
    shelf.camp = current_camp
    flash[:notice] = t('.create') if shelf.save
    respond_with shelf, location: [:admin, shelf]
  end

  def update
    shelf.user = current_user if shelf.user_id.blank?
    flash[:notice] = t('.update') if shelf.update_attributes(params[:shelf])
    respond_with shelf, location: [:admin, shelf]
  end
end