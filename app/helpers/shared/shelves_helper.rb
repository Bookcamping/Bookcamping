module Shared::ShelvesHelper
  def render_shelves(shelves)
    render partial: 'shared/shelves/shelves', object: shelves
  end
end

