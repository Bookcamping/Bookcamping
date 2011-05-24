module BooksHelper
  def render_description(book)
    text = auto_link(book.description)
    text = text.gsub(/(#\w+)/, '<a>\0</a>')
    text = RDiscount.new(text, :smart).to_html.html_safe

    text = text.sub(/<em>[^<]*<\/em>/, '<a href="' + url_for(book) + '">\0</a>')
  end
end
