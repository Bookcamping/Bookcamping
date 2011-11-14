class Personal::UserShelvesController < Personal::ApplicationController
  respond_to :html
  expose(:profile_shelves) { current_user.profile_shelves_for current_camp }
  expose(:user_shelves) { current_user.user_shelves }
  expose(:user_shelf)

  # ALIASES
  expose(:shelves) { user_shelves }
  expose(:shelf) { user_shelf }

  def index

  end

  def edit

  end

  def new

  end

  def show

  end

  def create
    shelf.user = current_user
    shelf.camp = current_camp
    flash[:notice] = 'Lista creada. Gracias.' if shelf.save
    respond_with shelf, location: personal_user_shelves_path
  end

  def update
    flash[:notice] = 'Lista actualizada. Gracias.' if shelf.update_attributes(params[:user_shelf])
    respond_with shelf, location: [:personal, shelf]
  end
end

