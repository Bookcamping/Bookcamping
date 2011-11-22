class Admin::VersionsController < Admin::ApplicationController
  expose(:page) { params[:page] ? params[:page] : 1 }
  expose(:versions) { current_camp.versions.order('id DESC').limit(50) }
  expose(:version)

  def show
    case version.item_type
      when 'UserShelf'
        redirect_to personal_user_shelf_path(version.item_id)
      when 'CampShelf'
        redirect_to camp_shelf_path(version.item_id)
      when 'Book'
        redirect_to book_path(version.item_id)
      when 'Comment'
        comment = Comment.find version.item_id
        redirect_to comment.resource
      when 'Bookmark'
        bookmark = Bookmark.find version.item_id
        redirect_to book_path(bookmark.book)
      else
        redirect_to root_path, :notice => "No encontrado #{version.item_type}"
    end
  end

  def notify
    ActivityMailer.last_site_activity(current_camp.id, current_user.id).deliver if current_user.email?
    redirect_to admin_versions_path
  end
end
