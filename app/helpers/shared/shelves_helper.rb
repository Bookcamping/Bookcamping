module Shared::ShelvesHelper
  def render_shelves(shelves, book = nil)
    render partial: 'shared/shelves/shelves', locals:
        {shelves: shelves, book: book}
  end

  def render_shelf(shelf, link)
    render partial: 'shared/shelves/shelf', locals:
        {shelf: shelf, link: link}
  end

  def render_shelf_header(shelf)
    render partial: 'shared/shelves/shelf_header', locals:
        {shelf: shelf}
  end
end

