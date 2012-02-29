class LicensesController < ApplicationController
  respond_to :html
  expose_resource :license

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
    flash[:notice] = t('.create') if license.save
    respond_with license
  end

  def update
    flash[:notice] = t('.update') if license.update_attributes(params[:license])
    respond_with license
  end

  def destroy
    destroy!
  end

end

