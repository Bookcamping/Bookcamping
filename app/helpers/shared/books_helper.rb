module Shared::BooksHelper
  def render_books(books, background, shelf = nil)
    render :partial => 'shared/books/books', :locals => {:books => books, :background => background, :shelf => shelf}
  end

  def license_type_icon(book)
    name = book.license.license_type
    image_tag("/images/ui3/license_icons/#{name}.png", :class => 'license-type')
  end


end

