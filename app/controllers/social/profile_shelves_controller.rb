class Social::ProfileShelvesController < ApplicationController
  respond_to :html
  expose(:user) { User.find params[:user_id] }
  expose(:shelves) { user.profile_shelves.public }
  expose(:shelf) { shelves.by_param(params[:id]) }

  def show

  end
end

