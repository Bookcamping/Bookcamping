class CommentsController < ApplicationController
  respond_to :html, :js, :json
  expose(:book) { current_camp.books.find params[:book_id] if params[:book_id].present? }
  expose(:post) { current_camp.posts.find params[:post_id] if params[:post_id].present? }
  expose(:parent) { book ? book : post }
  expose(:comments) { parent.comments }
  expose(:comment)

  def create
    if params[:email].blank?
    comment.user = current_user unless params[:anonymous]
    comment.camp = current_camp
    flash[:notice] = t('comments.notice.create') if comment.save
    respond_with comment, :location => comment.resource
    else
      redirect_to comment.resource
    end

  end

  def destroy
    authorize! :destroy, comment
    flash[:notice] = "Comentario borrado." if comment.destroy
    respond_with comment, :location => comment.resource
  end
end
