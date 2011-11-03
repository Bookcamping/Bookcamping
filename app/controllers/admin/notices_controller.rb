class Admin::NoticesController < Admin::ResourceController

  def index
    index!
  end

  def new
    @notice = Notice.new(published_at: Time.now)
    new!
  end

  def create
    @notice = Notice.new(params[:notice])
    @notice.level = 'anuncio'
    create!
  end

  def edit
    edit!
  end

  def show
    redirect_to admin_notices_path
  end
end

