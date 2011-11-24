class Backend::UsersController < Backend::ResourceController
  expose_with_slug
  expose_resource :user
  #expose(:user) { params[:id].present? ? User.find_by_slug(params[:id]) : User.new(params[:user]) }

end

