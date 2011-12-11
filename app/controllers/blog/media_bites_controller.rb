class Admin::Blog::MediaBitesController < Admin::ResourceController
  expose_resource :media_bite

  def create
    media_bite.camp = current_camp
    media_bite.user = current_user
    create! [:admin, media_bite]
  end

  def update
    update! [:admin, media_bite]
  end

  def destroy
    destroy! [:admin, :media_bites]
  end

end
