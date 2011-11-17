class ShelfPresenter < ApplicationPresenter
  presents :shelf

  def header
    h.render partial: 'shared/shelves/shelf_header', locals: {shelf: shelf}
  end

  def items
    items = shelf.books.includes(:license)
    @rp = ReferencesPresenter.new(items, {shelf: shelf, url_builder: self}, h)
    @rp.render
  end

  def build_url_for(reference)
    [shelf, reference]
  end
end

