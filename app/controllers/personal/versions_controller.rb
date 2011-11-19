class Personal::VersionsController < ApplicationController
  before_filter :require_user

  expose(:user) { current_user }
  expose(:versions) { user.versions.order('id DESC').limit(20) }

  def index
  end
end

