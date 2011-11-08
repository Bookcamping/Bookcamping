class References::CommentsController < Shared::CommentsController
  expose(:parent) { current_camp.books.find params[:book_id] }
end

