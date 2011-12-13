class Blog::MediaBitesController < ApplicationController
  respond_to :html
  expose_resource :media_bite

  def index
    index!
  end

  def new
    new!
  end

  def edit
    edit!
  end

  def show
    show!
  end
  
  def create
    media_bite.camp = current_camp
    media_bite.user = current_user
    create! [media_bite]
  end

  def update
    update! [media_bite]
  end

  def destroy
    destroy! [:media_bites]
  end
end
