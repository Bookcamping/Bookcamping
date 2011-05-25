class VersionsController < ApplicationController
  expose(:versions) { Version.order('id DESC').limit(20)}
  expose(:version)

  def index
    authorize! :read, Version
  end

  def show
    case version.item_type
      when 'Book'
        redirect_to book_path(version.item_id)
      when 'Comment'
        comment = Comment.find version.item_id
        redirect_to comment.resource
      else
        redirect_to root_path, :notice => 'No encontrado'
    end
  end
end
