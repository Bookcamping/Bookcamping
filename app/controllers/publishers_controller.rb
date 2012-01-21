class PublishersController < ApplicationController
  respond_to :html
  expose_resource :publisher

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
    create! publishers_path
  end

  def update
    update! publisher_path(publisher)
  end
end
