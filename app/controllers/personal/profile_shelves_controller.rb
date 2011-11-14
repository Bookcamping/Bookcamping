class Personal::ProfileShelvesController < Personal::ApplicationController

  expose(:shelves) { current_user.profile_shelves.by_camp(current_camp) }
  expose(:shelf) { shelves.by_param params[:id] }

  def show

  end
end