class TagsController < ApplicationController
  respond_to :html
  expose_with_slug
  expose_resource :tag, as: 'rtag'

  def index
    index!
  end

  def show
    show!
  end
end

