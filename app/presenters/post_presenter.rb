class PostPresenter < ApplicationPresenter
  presents :post

  def author

  end

  def body
    @body ||= render_body
  end

  def used_media
    @used_media ||= []
  end


  protected
  def render_body
    if post.content_type == 'markdown'
      markdown(render_body_media_bites)
    else
      h.raw(post.body)
    end
  end

  def render_body_media_bites(options = {})
    options.reverse_merge!(thumb: false)

    post.body.gsub /#\{MEDIA:\s*([^}]*)\s*}/ do
      media = MediaBite.find_by_id $1
      if media
        add_media_used(media)
        media.render_media(options)
      else
        "*{ERROR: Media '#{$1}' no encontrado!}*"
      end
    end
  end

  def add_media_used(media)
    used_media << media
  end


end

