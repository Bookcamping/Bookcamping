class ColorsController < ApplicationController
  before_filter :require_admin
  respond_to :html

  expose_resource :color

  def index
    index!
  end

  def new
    new!
  end

  def edit
    edit!
  end

  def update
    update! colors_path
  end

  def create
    create! colors_path
  end

  def destroy
    destroy! colors_path
  end

end

