# encoding: utf-8
class Shared::BooksController < ApplicationController
  respond_to :html, :json

  expose(:books) { current_camp.books }
  expose(:book)
  expose(:shelf) {}

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
    flash[:notice] = "¡Referencia añadida! ¡Gracias!" if book.save
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

end

