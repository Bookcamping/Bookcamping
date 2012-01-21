class Admin::CampsController < ApplicationController
  respond_to :html
  expose_resource :camp

  def index
    index!
  end

  def show
    show!
  end

  def new
    new!
  end

  def enter
    if current_user.admin? 
      session[:camp_id] = params[:id]
      flash[:notice] = "Nos vamos"
    end
    redirect_to root_path
  end

  def edit
    edit!
  end

  def create
    create! [:admin, camp]
  end

  def update
    update! [:admin, camp]
  end

end
