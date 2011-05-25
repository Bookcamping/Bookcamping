class ShelvesController < ApplicationController
  respond_to :html, :js
  expose(:shelves) { Shelf.all }
  expose(:shelf)
  expose(:latest_books) { Book.order('id DESC').limit(10) }

  def browse
    Book.where(:title => nil).each do |book|
      book.update_attributes(:title => book.book_title, :description => book.clean_description)
    end
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
