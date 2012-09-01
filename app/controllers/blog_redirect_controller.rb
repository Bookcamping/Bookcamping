class BlogRedirectController < ApplicationController
  def index
    redirect_to 'http://blog.bookcamping.cc'
  end

  def show
    post_id = BLOG_REDIRECTS.fetch(params[:id])
    url = post_id ? "post/#{post_id}/#{params[:id]}" : ""
    redirect_to "http://blog.bookcamping.cc/#{url}"
  end
end
