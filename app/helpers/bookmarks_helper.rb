module BookmarksHelper
  def render_bookmarks(book)
    render :partial => 'bookmarks/bookmarks', :locals => {:book => book}
  end
end
