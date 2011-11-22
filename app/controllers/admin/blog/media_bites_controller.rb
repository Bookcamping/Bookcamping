class Admin::Blog::MediaBitesController < Admin::ResourceController
  def index
    @media_bites = MediaBite.order('id DESC')
    index!
  end

  def create
    @media_bite = MediaBite.new params[:media_bite]
    @media_bite.camp = current_camp
    @media_bite.user = current_user
    create!
  end

  def destroy
    destroy! { [:admin, :media_bites] }
  end

end
