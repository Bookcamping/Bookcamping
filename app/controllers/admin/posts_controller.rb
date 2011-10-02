class Admin::PostsController < Admin::ResourceController
  expose(:media_bites) { current_camp.media_bites.order('updated_at DESC') }

  def index
    page = params[:page].present? ? params[:page] : 1
    @posts = current_camp.posts.order('published_at DESC').page(page)
  end

  def create
    @post = Post.new params[:post]
    @post.user = current_user
    @post.camp = current_camp
    create!
  end
end