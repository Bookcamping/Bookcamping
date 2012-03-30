# encoding: utf-8
# Controller for CampShelf models
class CampShelvesController < ApplicationController
  respond_to :html
  expose_with_slug

  expose(:on_member?) { params[:id].present? }
  expose(:current_camp) { on_member? ? camp_shelf.camp : load_camp_from_request }
  expose(:parent) { on_member? ? Site.new : current_camp }

  expose_resource :camp_shelf
  delegate_resource :shelf, to: :camp_shelf
  expose(:camp_shelves) { parent.camp_shelves }
  expose(:valid_owners) { current_user.user_groups.all.unshift(current_user) }

  def index
  end


  def show
    show!
  end

  def new
    new!
  end

  def edit
    edit!
  end

  def create
    if current_camp.lock_camp_shelves? && !current_user.admin?
      redirect_to camp_shelves_path, notice: 'No se pueden crear estanterías'
    else
      unless valid_owners.include?(camp_shelf.user)
        camp_shelf.user ||= current_user
      end
      camp_shelf.camp = current_camp
      create! [camp_shelf]
    end
    expire_fragment ['camp_shelves_list', current_camp]
  end

  def update
    update! [camp_shelf]
    expire_fragment ['camp_shelves_list', current_camp]
  end

  def destroy
    destroy!
    expire_fragment ['camp_shelves_list', current_camp]
  end

end
