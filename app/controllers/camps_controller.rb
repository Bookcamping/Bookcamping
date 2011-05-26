class CampsController < ApplicationController
  respond_to :html, :json
  expose(:camps) { Camp.all }
  expose(:camp)

  def enter
    if Rails.env.development?
      session[:camp_id] = params[:id]
      flash[:notice] = "Nos vamos"
    end
    redirect_to root_path
  end

  def edit
    authorize! :edit, camp
  end

  def update
    authorize! :update, camp
    flash[:notice] = t('camps.notice.update') if camp.update_attributes(params[:camp])
    respond_with camp, :location => root_path
  end

end
