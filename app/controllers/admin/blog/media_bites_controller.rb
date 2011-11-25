class Admin::Blog::MediaBitesController < Admin::ResourceController
  expose_resource :media_bite

  def create
    create! [:admin, media_bite]
  end

  def update
    update! [:admin, media_bite]
  end

  def destroy
    destroy! [:admin, :media_bites]
  end

end
