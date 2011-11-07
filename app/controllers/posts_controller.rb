class PostsController < ApplicationController

  expose(:posts) { current_camp.posts.public.order('published_at DESC')}
  expose(:post) { params[:id].present? ? posts.find(params[:id]) : posts.first }
  expose(:comments) { post.comments }
  expose(:new_comment) { Comment.new(resource: post) }

  def index
    respond_to do |format|
      format.html
      format.json
      format.atom { render layout: false}
      format.rss { redirect_to posts_path(format: :atom), status: :moved_permanently}
    end
  end

  def show
  end
end
