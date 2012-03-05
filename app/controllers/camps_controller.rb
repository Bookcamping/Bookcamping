class CampsController < ApplicationController
  before_filter :require_admin, except: [:enter]
  respond_to :html

  expose_resource :camp

  def enter
    if !Rails.env.production? or (current_user and current_user.admin?)
      camp = Camp.find params[:id]
      session[:camp_id] = camp.id
      flash[:notice] = "Nos vamos a #{camp.name}"
    end
    redirect_to root_path
  end

  def index
    index!
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
    create!
  end

  def update
    update!
  end

end
