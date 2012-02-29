class Blog::PostsController < ApplicationController
  respond_to :html
  respond_to :atom, :rss, only: :index

  expose_with_slug
  expose_resource :post

  expose(:posts) { Post.published.order('published_at DESC').limit(3) }
  expose(:all_posts) do
    Post.published.order('published_at DESC')
  end
  expose(:media_bites) { MediaBite.all }

  def index
    respond_to do |format|
      format.html
      format.json
      format.atom { render layout: false}
      format.rss { redirect_to posts_path(format: :atom), status: :moved_permanently}
    end
  end

  def archive
  end

  def show
    authorize! :show, post
  end

  def new
    new!
  end

  def edit
    edit!
  end

  def create
    post.user = current_user
    create!
    expire_fragment("recent_posts")
  end

  def update
    update! post
    expire_fragment("recent_posts")
  end
end
