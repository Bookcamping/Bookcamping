class References::CommentsController < Shared::CommentsController
  expose(:parent) { current_camp.references.find params[:reference_id] }
end

