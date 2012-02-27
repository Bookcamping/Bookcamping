class VersionsController < ApplicationController
  respond_to :html, :js, :json

  expose(:versions) do
    v = Version.scoped
    v = v.where(camp_id: current_camp.id)
    v = v.order('id DESC')
    v = v.limit(50)
    v
  end
  expose(:version) { Version.find params[:id] }

  def index
    respond_with versions   
  end

  def show
    case version.item_type
    when 'UserShelf'
      redirect_to personal_user_shelf_path(version.item_id)
    when 'CampShelf'
      camp_shelf = CampShelf.find version.item_id
      redirect_to camp_shelf
    when 'Book'
      book = Book.find version.item_id
      redirect_to book
    when 'Comment'
      comment = Comment.find version.item_id
      redirect_to comment.resource
    end
  end

  def email
    current_camp.last_activity_email = Time.now
    current_camp.save
  end

end

