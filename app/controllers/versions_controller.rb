class VersionsController < ApplicationController
  respond_to :html, :js, :json

  expose(:versions) do
    Version.order('id DESC').limit(50)
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
      when 'Page'
        page = Page.find version.item_id
        redirect_to page
    end
  end

  def email
    camp = Camp.find 1
    @last_activity_email = camp.last_activity_email
    if @last_activity_email.present?
      distance_in_seconds = Time.now - @last_activity_email
      @versions = Site.site_activity(@last_activity_email)
      if distance_in_seconds > 1.hour
        if @versions.count > 0
          ActivityMailer.site_activity(@last_activity_email).deliver
          @message = "Email enviado!"
        else
          @message = "No hay actividad nueva"
        end
      else
        @message = "No ha pasado suficiente tiempo"
      end
    else
      @last_activity_email = Time.now
    end
    #current_camp.last_activity_email = Time.now
    #current_camp.save
  end

end

