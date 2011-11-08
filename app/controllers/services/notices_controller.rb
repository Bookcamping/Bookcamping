class Services::NoticesController < ApplicationController
  respond_to :json

  def index
    post = Post.scoped.order('id DESC').first
    html = "<a href='/blog'>#bookcamping blog: #{post.title}</a>"
    @notices = Notice.all
    @notices.unshift(Notice.new(body: html, level: 'post'))
    respond_with @notices
  end
end

