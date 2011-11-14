class Social::BooksController < Shared::BooksController
  expose(:profile_shelf) { current_camp.profile_shelves.find(params[:profile_shelf_id]) if params[:profile_shelf_id].present? }
  expose(:user_shelf) { current_camp.user_shelves.find(params[:user_shelf_id]) if params[:user_shelf_id].present? }
  expose(:shelf) { profile_shelf.present? ? profile_shelf : user_shelf}
end

