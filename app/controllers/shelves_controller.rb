class ShelvesController < ApplicationController
  respond_to :html, :js
  expose(:shelves) { Shelf.all }
  expose(:shelf)
  expose(:latest_books) { Book.order('id DESC').limit(10) }

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
    authorize! :create, shelf
    flash[:notice] = "Lista creada." if shelf.update_attributes(params[:shelf])
    respond_with shelf
  end

  def update
    authorize! :update, shelf
    flash[:notice] = "Lista modificada." if shelf.update_attributes(params[:shelf])
    respond_with shelf
  end

end
