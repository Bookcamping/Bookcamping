class Social::VersionsController < ApplicationController
  respond_to :html, :js, :json

  expose(:user) { User.find_by_param params[:user_id] }
  expose(:versions) { Activity.for_user(user, page_param)}

  def index
  end
end

