class Personal::UserShelvesController < Personal::ApplicationController
  respond_to :html, :json

  expose_with_slug
  expose(:profile_shelves) { current_user.profile_shelves }
  expose(:user_shelves) { current_user.user_shelves }
  expose(:user_shelf)

  # ALIASES
  expose(:shelves) { user_shelves }
  expose(:shelf) { user_shelf }

  include Rails.application.routes.url_helpers
  include ActionDispatch::Routing::UrlFor

  def create
    shelf.user = current_user
    shelf.camp = current_camp
    authorize! :create, shelf
    flash[:notice] = 'Lista creada. Gracias.' if shelf.save
    respond_with shelf, location: personal_user_shelves_path
  end

  def update
    authorize! :update, shelf
    flash[:notice] = 'Lista actualizada. Gracias.' if shelf.update_attributes(params[:user_shelf])
    respond_with shelf, location: [:personal, shelf]
  end

  def destroy
    authorize! :destroy, shelf
    flash[:notice] = "Lista '#{shelf.name}' borrada." if shelf.destroy
    respond_with shelf, location: [:personal, shelf]
  end

  def bulk_add
    shelf = current_user.user_shelves.find_by_name(params[:shelf_name])
    shelf ||= UserShelf.create! do |s|
      s.user = current_user
      s.name = params[:shelf_name]
      s.visibility = 'public'
      s.color = Shelf::COLORS[0]
    end
    params[:reference_ids].split(',').each do |reference_id|
      shelf.add_reference_id(reference_id)
    end

    url = url_for [:personal, shelf]
    respond_with do |format|
      format.html { redirect_to url }
      format.json { render json: {name: shelf.name, count: shelf.books_count, url: url} }
    end
  end
end

