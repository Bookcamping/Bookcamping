class Personal::ProfileShelvesController < Personal::ApplicationController

  expose(:shelf) do
    scope = ProfileShelf.where(user_id: current_user.id).where(camp_id: current_camp.id)
    if params[:id] == 'favoritos'
      scope.where(rol: 'like_it').first
    elsif params[:id] == 'para_leer'
      scope.where(rol: 'read_later').first
    end
  end

  def show

  end
end