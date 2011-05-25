module ShelvesHelper
  def render_shelves(shelves)
        render :partial => 'shelves/shelves', :locals => {:shelves=> shelves}
  end
end
