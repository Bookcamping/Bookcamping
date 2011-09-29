class PostsController < ApplicationController
  respond_to :html, :json
  expose(:posts) do
    posts = (current_user and current_user.admin?) ? current_camp.posts : current_camp.posts.public
    posts.order('published_at DESC')
  end
  expose(:post)

  def index
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
    post.camp = current_camp
    post.user = current_user
    flash[:notice] = 'Entrada creada! Epaaa!' if post.save
    respond_with post
  end

  def update
    flash[:notice] = 'Entrada actualizada! Gracias!' if post.update_attributes(params[:post])
    respond_with post
  end

end
