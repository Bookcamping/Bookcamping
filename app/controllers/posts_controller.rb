class PostsController < ApplicationController
  respond_to :html, :json
  expose(:posts) { current_camp.posts.public.order('published_at DESC')}
  expose(:post) { params[:id].present? ? posts.find(params[:id]) : posts.first }

  def index
  end

  def show
  end
end
