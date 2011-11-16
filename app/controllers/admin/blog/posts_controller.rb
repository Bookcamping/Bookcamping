class Admin::Blog::PostsController < Admin::ResourceController
  expose(:media_bites) { MediaBite.order('updated_at DESC') }
  expose(:last_comments) { Comment.where(resource_type: 'Post').order('id DESC').limit(20) }

  def index
    page = params[:page].present? ? params[:page] : 1
    @posts = Post.order('published_at DESC').page(page)
  end

  def create
    @post = Post.new params[:post]
    @post.user = current_user
    @post.camp = current_camp
    create! { [:admin, @post ] }
  end

  def update
    update! { [:admin, @post] }
  end
end
