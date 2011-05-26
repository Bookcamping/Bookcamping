module BooksHelper

  def render_description(book)
    text = auto_link(book.description)
    text = text.gsub(/(#\w+)/, '<a>\0</a>')
    text = RDiscount.new(text, :smart).to_html.html_safe
    text = text.sub(/<em>[^<]*<\/em>/, '<a href="' + url_for(book) + '">\0</a>') unless book.title.present?
    text
  end

  def render_book(book, ctx = :book)
    render :partial => 'books/book', :locals => {:book => book, :ctx => ctx}
  end

  def render_media(book)
    if /youtube.com\/watch\?v=([\w\s\-_]*)/.match(book.media)
      "<iframe width='360' height='300' src='http://www.youtube.com/embed/#{$1}' frameborder='0' allowfullscreen></iframe>".html_safe
    else
      book.url.present? ? link_to(image_tag(book.media), book.url) : image_tag(book.media)
    end
  end
end
