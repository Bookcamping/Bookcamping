class Admin::Blog::PostsController < ApplicationController
  expose_with_slug
  expose_resource :post
  expose(:media_bites) { MediaBite.order('updated_at DESC') }
  expose(:last_comments) { Comment.where(resource_type: 'Post').order('id DESC').limit(20) }

  def index
    index!
  end

  def create
    post.user = current_user
    post.camp = current_camp
    create! [post ] 
  end

  def update
    update! [post] 
  end

  def destroy
    destroy! [:posts] 
  end
end
