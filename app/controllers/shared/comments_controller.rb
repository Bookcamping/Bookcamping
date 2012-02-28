# encoding: utf-8
class Shared::CommentsController < ApplicationController
  respond_to :html, :js, :json
#  expose(:post) { current_camp.posts.find params[:post_id] if params[:post_id].present? }
#  expose(:parent) { reference ? reference : post }
  expose(:comments) { parent.comments }
  expose(:comment)

  def create
    if params[:email].blank?
      comment.user = current_user unless params[:anonymous]
      comment.camp = current_camp
      flash[:notice] = "¡Gracias por tu comentario!" if comment.save
      respond_with comment, :location => comment.resource
    else
      redirect_to comment.resource
    end
  end
 end
