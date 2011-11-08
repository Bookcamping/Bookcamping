module BookListsHelper
  def render_book_lists(lists)
    render :partial => 'book_lists/book_lists', :locals => {:book_lists => lists}
  end
end
