class Admin::MediaBitesController < Admin::ResourceController
  def index
    index!
  end

  def create
    @media_bite = MediaBite.new params[:media_bite]
    @media_bite.camp = current_camp
    @media_bite.user = current_user
    create!
  end
end
