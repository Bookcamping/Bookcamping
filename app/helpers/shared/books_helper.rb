module Shared::BooksHelper
  def render_books(books, background, shelf = nil)
    render :partial => 'shared/books/books', :locals => {:books => books, :background => background, :shelf => shelf}
  end

  def render_book_item(book, book_link, background = 'gray')
    render partial: 'shared/books/book_item', locals:
        {book: book, book_link: book_link, background_color: background}
  end

  def license_type_icon(book)
    name = book.license.license_type
    image_tag("/images/ui3/license_icons/#{name}.png", :class => 'license-type')
  end


end

