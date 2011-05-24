module BooksHelper
  def prepare_text(text)
    text = auto_link(text)
    text = text.gsub(/(#\w+)/, '<a>\0</a>')
    text = RDiscount.new(text, :smart).to_html.html_safe
  end
end
