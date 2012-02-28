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
    create!
  end

  def update
    update!
  end

  def destroy
    destroy!
  end

end

