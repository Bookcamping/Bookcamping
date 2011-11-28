# encoding: utf-8
class Shared::BooksController < ApplicationController
  respond_to :html, :json
  before_filter :require_user, only: [:new, :edit, :create, :update, :destroy]

  expose(:shelf) { Site.new }
  expose(:books) { shelf.books }
  expose(:book)

  def new
    authorize! :manage, Book
  end

  def edit
    authorize! :edit, book
  end

  def create
    book.user = current_user
    book.camp = current_camp
    authorize! :create, book
    flash[:notice] = "¡Referencia añadida! ¡Gracias!" if current_user.add_book(book)
    respond_with book
  end

  def update
    authorize! :update, book
    rol = current_user.rol ? current_user.rol.to_sym : nil
    flash[:notice] = 'Cambios guardados. ¡Gracias!' if book.update_attributes(params[:book], :as => rol)

    respond_with book
  end

  def destroy
    authorize! :destroy, book
    book.destroy
    respond_with book, :location => root_path
  end

  protected
  def notify_book_created
    ActivityMailer.notify_reference(:created, book.id, current_user.id).deliver
  end

  def notify_book_updated
    ActivityMailer.notify_reference(:updated, book.id, current_user.id).deliver
  end

end

