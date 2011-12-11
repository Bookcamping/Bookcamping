class Blog::CommentsController < Shared::CommentsController
  expose(:parent) { Posts.find params[:post_id] }
end

