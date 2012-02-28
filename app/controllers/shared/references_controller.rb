# encoding: utf-8
class Shared::ReferencesController < ApplicationController
  respond_to :html, :json
  before_filter :require_user, except: [:index, :show]

  expose(:shelf) { Site.new }
  expose(:references) { shelf.references }
  expose(:reference)
  expose(:pajax?) { request.headers['X-PJAX'].present? }

  def new
    authorize! :manage, Reference
  end

  def edit
    authorize! :edit, reference
  end

  def create
    reference.user = current_user
    reference.camp = current_camp
    authorize! :create, reference
    flash[:notice] = "¡Referencia añadida! ¡Gracias!" if current_user.add_reference(reference)
    respond_with reference
  end

  def update
    authorize! :update, reference
    rol = current_user.rol ? current_user.rol.to_sym : nil
    flash[:notice] = 'Cambios guardados. ¡Gracias!' if reference.update_attributes(params[:reference], :as => rol)

    respond_with reference
  end

  def destroy
    authorize! :destroy, reference
    reference.destroy
    respond_with reference, :location => root_path
  end

  expose(:reference_title) { params[:title] }
  expose(:search) { Search.new(:references, current_camp.references, reference_title) }
  def select
  end

  def add
    reference = Reference.find params[:id]
    shelf.add_reference(reference, current_user)
    redirect_to shelf
  end


  protected
  def notify_reference_created
    ActivityMailer.notify_reference(:created, reference.id, current_user.id).deliver
  end

  def notify_reference_updated
    ActivityMailer.notify_reference(:updated, reference.id, current_user.id).deliver
  end

end

