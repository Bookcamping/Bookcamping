# encoding: utf-8
class ReferencePresenter < ApplicationPresenter
  presents :reference

  def linked_title
    h.link_to_unless_current(reference.title, reference)
  end

  def license_icon
    h.raw "<img src='#{reference.license.icon}' alt='#{reference.license.name}'>"
  end

  def date
    h.content_tag :span, reference.date, :class => 'date' if reference.date.present?
  end

  def authors
    h.content_tag :span, reference.authors, :class => 'authors' if reference.authors.present?
  end

  def editor
    h.content_tag :span, reference.editor, :class => 'editor' if reference.editor.present?
  end

  def description
    h.markdown reference.description
  end

  def user(message = 'Por ')
    user = reference.user
    h.content_tag :span, message.html_safe + h.link_to("#{user.name}", user), class: 'user' if user
  end

  def download_visible?
    reference.url.present? and reference.license.libre?
  end

  def download_link
    h.link_to("¿Lo quieres? ¡Lo tienes! <b>&dArr;</b> Descargar!".html_safe, reference.url, :class => 'important download')
  end

  def media
    if reference.media?
      render_media
    end
  end

  def social
    h.render partial: 'shared/social/social'
  end

  def camp_shelves
    h.render_shelves reference.camp_shelves, reference
  end

  def comments
    h.render partial: 'shared/comments/comments', locals:
        {comments: reference.comments,
         new_comment: Comment.new(:resource => reference)}
  end

  protected
  def render_media
    if /youtube.com\/watch\?v=([\w\s\-_]*)/.match(reference.media) or /youtu\.be\/(.*)/.match(reference.media)
      frame = "<iframe width='339' height='223' src='http://www.youtube.com/embed/#{$1}' frameborder='0' allowfullscreen></iframe>"
      link = h.content_tag(:div, h.link_to('&rArr; Ver en youtube'.html_safe, reference.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /vimeo.com\/(\d+)/.match(reference.media)
      frame = '<iframe src="http://player.vimeo.com/video/' + $1 + '?title=0&amp;byline=0&amp;portrait=0" width="339" height="256" frameborder="0"></iframe>'
      link = h.content_tag(:div, h.link_to('&rArr; Ver en vimeo'.html_safe, reference.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /docid=(.+)/.match(reference.media)
      frame = "<embed id=VideoPlayback src=http://video.google.com/googleplayer.swf?docid=#{$1}&hl=es&fs=true style=width:339px;height:223px allowFullScreen=true allowScriptAccess=always type=application/x-shockwave-flash> </embed>"
      link = h.content_tag(:div, h.link_to('&rArr; Ver en google video'.html_safe, reference.media, :class => 'notice'), :class => 'media-link')
      (frame + link).html_safe
    elsif /^</.match(reference.media)
      reference.media.html_safe
    else
      h.link_to(h.image_tag(reference.media[0..200], class: 'cover'), reference)
    end
  end

end

