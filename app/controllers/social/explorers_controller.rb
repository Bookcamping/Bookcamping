class Social::ExplorersController < ApplicationController
  respond_to :html
  expose(:site) { Site.new }
  expose(:user_shelves) { site.explore_user_shelves}
  expose(:users) { site.explore_users }

  def show

  end
end

