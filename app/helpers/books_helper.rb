# encoding: utf-8
module BooksHelper

  def render_description(book)
    text = auto_link(book.description)
    text = text.gsub(/(#\w+)/, '<a>\0</a>')
    text = RDiscount.new(text, :smart).to_html.html_safe
    text = text.sub(/<em>[^<]*<\/em>/, '<a href="' + url_for(book) + '">\0</a>') unless book.title?
    text
  end

  def render_book(book, ctx = :book)
    render :partial => 'books/book', :locals => {:book => book, :ctx => ctx}
  end

  def render_book_list(books)
    render :partial => 'books/book_list', :locals => {:books => books}
  end

  def render_media(book)
    if /youtube.com\/watch\?v=([\w\s\-_]*)/.match(book.media) or /youtu\.be\/(.*)/.match(book.media)
      frame = "<iframe width='339' height='223' src='http://www.youtube.com/embed/#{$1}' frameborder='0' allowfullscreen></iframe>"
      link = content_tag(:div, link_to('&rArr; Ver en youtube'.html_safe, book.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /vimeo.com\/(\d+)/.match(book.media)
      frame = '<iframe src="http://player.vimeo.com/video/' + $1 + '?title=0&amp;byline=0&amp;portrait=0" width="339" height="256" frameborder="0"></iframe>'
      link = content_tag(:div, link_to('&rArr; Ver en vimeo'.html_safe, book.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /docid=(\d+)/.match(book.media)
      frame = "<embed id=VideoPlayback src=http://video.google.com/googleplayer.swf?docid=#{$1}&hl=es&fs=true style=width:339px;height:223px allowFullScreen=true allowScriptAccess=always type=application/x-shockwave-flash> </embed>"
      link = content_tag(:div, link_to('&rArr; Ver en google video'.html_safe, book.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    else
      book.url? ? link_to(image_tag(book.media), book.url) : image_tag(book.media)
    end
  end

end
