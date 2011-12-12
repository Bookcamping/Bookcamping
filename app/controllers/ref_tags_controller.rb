class RefTagsController < ApplicationController
  respond_to :html

  expose_with_slug
  expose_resource :ref_tag
  expose(:references) { ref_tag.references } 

  def index
    index!
  end

  def show
    show!
  end
end

