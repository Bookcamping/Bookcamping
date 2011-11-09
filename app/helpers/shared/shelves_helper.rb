module Shared::ShelvesHelper
  def render_shelves(shelves, book = nil)
    render partial: 'shared/shelves/shelves', locals:
        {shelves: shelves, book: book}
  end
end

