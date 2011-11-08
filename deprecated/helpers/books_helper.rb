# encoding: utf-8
module BooksHelper



  def render_book(book, ctx = :book)
    render :partial => 'books/book', :locals => {:book => book, :ctx => ctx}
  end

  def render_book_list(books)
    render :partial => 'books/book_list', :locals => {:books => books}
  end


end
