class ReferencesController < ApplicationController
  before_filter :require_user, except: [:index, :show, :search]
  respond_to :html, :json

  expose(:current_camp) { params[:id].present? ? reference.camp : load_camp_from_request }

  expose(:search) { Search.new(:references, current_camp.references, params[:term]) }
  expose(:shelf) { find_parent_shelf }
  expose_resource :reference
  expose(:references) { shelf.present? ? shelf.references : Reference.scoped }

  def index
    index!
  end

  def show
    authorize! :view, reference
    if shelf.present?
      if request.headers['X-PJAX'].present?
        render action: 'show_pjax', layout: false
      else
        render action: 'show_in_shelf'
      end
    else
      render action: 'show'
    end
  end

  def new
    authorize! :manage, Reference
  end

  def edit
    authorize! :edit, reference
  end

  def create
    reference.user = current_user
    reference.camp = current_camp
    create!
  end

  def update
    update!
  end

  def destroy
    destroy! root_path
  end
end

