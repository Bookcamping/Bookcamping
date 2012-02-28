class ReferencesController < Shared::ReferencesController

  expose(:search) { Search.new(:references, current_camp.references, params[:term]) }
  expose(:current_camp) { params[:id].present? ? reference.camp : load_camp_from_request }

  def show
  end

end

