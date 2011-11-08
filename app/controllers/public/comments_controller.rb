class Public::CommentsController < Shared::CommentsController
  expose(:parent) { current_camp.posts.find params[:post_id] }
end

