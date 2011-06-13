module ShelvesHelper
  def render_shelves(shelves)
        render :partial => 'shelves/shelves', :locals => {:shelves=> shelves}
  end

  def shelf_books(books, shelf = nil)
    content_tag(:ul, render(:partial => 'shelves/book',
      :collection => books, :locals => {:shelf => shelf}), :class => 'item books')
  end

end
