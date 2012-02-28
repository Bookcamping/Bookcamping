class UserShelves::ReferencesController < Shared::ReferencesController
  expose(:shelf) { user_shelf }
  expose(:user_shelf) { UserShelf.find(params[:user_shelf_id]) }

end