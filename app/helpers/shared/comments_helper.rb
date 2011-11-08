# encoding: utf-8

module Shared::CommentsHelper
  def render_comments(comments, new_comment)
    render :partial => 'shared/comments/comments', :locals => {:comments => comments, :new_comment => new_comment}
  end

  def comment_author(comment)
    comment.user_id ? link_to(comment.user.name, comment.user) : 'Anónima'
  end
end
