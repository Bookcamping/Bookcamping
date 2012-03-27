class CampsController < ApplicationController
  before_filter :require_user, except: [:enter]
  before_filter :require_admin, only: [:index, :create]
  respond_to :html

  expose_resource :camp
  expose(:camps) { Camp.scoped }
  expose(:camp)
  expose(:latests_references) { camp.references.reorder('id DESC').limit(10) }

  def enter
    if !Rails.env.production? or (current_user and current_user.admin?)
      camp = Camp.find params[:id]
      session[:camp_id] = camp.id
      flash[:notice] = "Nos vamos a #{camp.name}"
    end
    redirect_to root_path
  end

  def new
    new!
  end

  def show
    show!
  end

  def edit
    authorize! :edit, camp
  end

  def create
    camp.user = current_user
    create!
  end

  def update
    update!
  end

end
