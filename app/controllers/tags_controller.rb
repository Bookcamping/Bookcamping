class TagsController < ApplicationController
  respond_to :html

  expose_resource :tag
  expose(:tags) { Tag.all }
  expose(:tag)

  def index
    index!
  end
end

