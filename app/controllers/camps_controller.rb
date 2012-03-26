class CampsController < ApplicationController
  before_filter :require_user, except: [:enter]
  respond_to :html

  expose(:camp) { current_camp }
  expose(:latests_references) { camp.references.reorder('id DESC').limit(10) }

  def enter
    if !Rails.env.production? or (current_user and current_user.admin?)
      camp = Camp.find params[:id]
      session[:camp_id] = camp.id
      flash[:notice] = "Nos vamos a #{camp.name}"
    end
    redirect_to root_path
  end

  def show
  end

  def edit
    authorize! :edit, camp
  end

  def update
    authorize! :update, camp
    flash[:notice] = t('.updated') if camp.update_attributes(params[:camp])
    respond_with camp, location: current_camp_path
  end

end
