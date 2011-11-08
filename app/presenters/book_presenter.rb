# encoding: utf-8
class BookPresenter < BasePresenter
  presents :book

  def linked_title
    h.link_to_unless_current(book.title, book)
  end

  def license_icon
    h.image_tag(book.license.icon)
  end

  def date
    h.content_tag :span, book.date, :class => 'date' if book.date.present?
  end

  def authors
    h.content_tag :span, book.authors, :class => 'authors' if book.authors.present?
  end

  def editor
    h.content_tag :span, book.editor, :class => 'editor' if book.editor.present?
  end

  def description
    h.markdown book.description
  end

  def user
    h.content_tag :span, "Por #{book.user.name}", class: 'user'
  end

  def download_visible?
    book.url.present? and book.license.libre?
  end

  def download_link
    h.link_to("¿Lo quieres? ¡Lo tienes! <b>&dArr;</b> Descargar!".html_safe, book.url, :class => 'important download')
  end

  def media
    render_media if book.media?
  end

  def social
    h.render partial: 'shared/social/social'
  end

  def camp_shelves
    h.render_shelves book.camp_shelves
  end

  def comments
    h.render partial: 'shared/comments/comments', locals:
        {comments: book.comments,
         new_comment: Comment.new(:resource => book)}
  end

  protected
  def render_media
    if /youtube.com\/watch\?v=([\w\s\-_]*)/.match(book.media) or /youtu\.be\/(.*)/.match(book.media)
      frame = "<iframe width='339' height='223' src='http://www.youtube.com/embed/#{$1}' frameborder='0' allowfullscreen></iframe>"
      link = h.content_tag(:div, h.link_to('&rArr; Ver en youtube'.html_safe, book.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /vimeo.com\/(\d+)/.match(book.media)
      frame = '<iframe src="http://player.vimeo.com/video/' + $1 + '?title=0&amp;byline=0&amp;portrait=0" width="339" height="256" frameborder="0"></iframe>'
      link = h.content_tag(:div, h.link_to('&rArr; Ver en vimeo'.html_safe, book.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /docid=(\d+)/.match(book.media)
      frame = "<embed id=VideoPlayback src=http://video.google.com/googleplayer.swf?docid=#{$1}&hl=es&fs=true style=width:339px;height:223px allowFullScreen=true allowScriptAccess=always type=application/x-shockwave-flash> </embed>"
      link = h.content_tag(:div, h.link_to('&rArr; Ver en google video'.html_safe, book.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    else
      book.url? ? h.link_to(h.image_tag(book.media), book.url) : h.image_tag(book.media)
    end
  end

end

