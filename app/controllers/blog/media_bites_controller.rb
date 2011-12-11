class Blog::MediaBitesController < Admin::ResourceController
  respond_to :html
  expose_resource :media_bite

  def index
    index!
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
