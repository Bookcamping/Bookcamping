class ShelvesController < ApplicationController
  respond_to :html, :js, :json
  expose(:shelves) { current_camp.shelves }
  expose(:shelf)
  expose(:latest_books) { current_camp.books.order('id DESC').limit(10) }

  def browse
  end

  def index
  end

  def show
  end

  def new
    authorize! :new, Shelf
  end

  def edit
    authorize! :edit, shelf
  end

  def create
    shelf.user = current_user
    shelf.camp = current_camp
    authorize! :create, shelf
    flash[:notice] = "Lista creada." if shelf.update_attributes(params[:shelf])
    respond_with shelf
  end

  def update
    authorize! :update, shelf
    flash[:notice] = "Lista modificada." if shelf.update_attributes(params[:shelf])
    respond_with shelf
  end

  def destroy
    authorize! :destroy, shelf
    flash[:notice] = t('shelves.notice.destroy') if shelf.destroy
    respond_with shelf, :location => shelves_path
  end

end
