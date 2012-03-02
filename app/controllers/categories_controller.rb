class CategoriesController < ApplicationController
  before_filter :require_admin
  respond_to :html

  expose_resource :category

  def index
    index!
  end

  def show
    redirect_to categories_path
  end

  def edit
    edit!
  end

  def new
    new!
  end

  def create
    create! categories_path
  end

  def update
    update! categories_path
  end

end