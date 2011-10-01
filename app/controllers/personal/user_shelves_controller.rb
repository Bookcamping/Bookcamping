class Personal::UserShelvesController < Personal::ApplicationController
  expose(:user_shelves) { current_user.user_shelves }
  expose(:user_shelf)

  # ALIASES
  expose(:shelves) { user_shelves }
  expose(:shelf) { user_shelf }

  def index

  end
end

