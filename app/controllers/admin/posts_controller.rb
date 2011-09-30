class Admin::PostsController < Admin::ResourceController

  def create
    @post = Post.new params[:post]
    @post.user = current_user
    @post.camp = current_camp
    create!
  end
end
