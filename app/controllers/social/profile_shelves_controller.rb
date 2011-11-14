class Social::ProfileShelvesController < ApplicationController
  respond_to :html
  expose(:user) { User.find params[:user_id] }
  expose(:shelves) { user.profile_shelves.by_camp(current_camp).public }
  expose(:shelf) { shelves.by_param(params[:id]) }

  def show

  end
end

