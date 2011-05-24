module CommentsHelper
  def render_comments(comments, new_comment)
    render :partial => 'comments/comments', :locals => {:comments => comments, :new_comment => new_comment}
  end
end
