class Blog::CommentsController < Shared::CommentsController
  expose(:parent) { Post.by_param params[:post_id] }
end

