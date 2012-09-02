class BlogRedirectController < ApplicationController
  def index
    redirect_to 'http://blog.bookcamping.cc'
  end

  def show
    if post_id
      url = "post/#{post_id}/#{params[:id]}"
      redirect_to "http://blog.bookcamping.cc/#{url}"
    else
      redirect_to 'http://blog.bookcamping.cc'
    end
  end

  protected
  def post_id
    BLOG_REDIRECTS_REGEXP.keys.each do |regexp|
      puts "TEST #{regexp}"
      return BLOG_REDIRECTS_REGEXP[regexp] if regexp =~ params[:id]
    end
    nil
  end
end
