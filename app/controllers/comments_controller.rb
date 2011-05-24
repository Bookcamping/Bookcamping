class CommentsController < ApplicationController
  respond_to :html, :js, :json
  expose(:book) { Book.find params[:book_id]}
  expose(:comments) { book.comments }
  expose(:comment)

  def create
    comment.user = current_user
    flash[:notice] = t('comments.notice.create') if comment.save
    respond_with comment, :location => comment.resource
  end
end
