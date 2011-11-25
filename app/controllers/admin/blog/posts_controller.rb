class Admin::Blog::PostsController < Admin::ResourceController
  expose_resource :post
  expose(:media_bites) { MediaBite.order('updated_at DESC') }
  expose(:last_comments) { Comment.where(resource_type: 'Post').order('id DESC').limit(20) }

  def create
    post.user = current_user
    post.camp = current_camp
    create! [:admin, post ] 
  end

  def update
    update! [:admin, post] 
  end

  def destroy
    destroy! [:admin, :posts] 
  end
end
