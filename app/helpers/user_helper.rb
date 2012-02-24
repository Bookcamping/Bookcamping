module UserHelper
  include ActionView::Helpers::AssetTagHelper

  def avatar_image(user, size = :medium)
    s = size == :small ? 40 : 80
    image_tag(avatar_url(user, s), alt: user.name, width: s, height: s)
  end

  def avatar_url(user, s)
    default_url = image_path("guest#{s}x#{s}.png")
    if user.email?
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{s}&d=#{CGI.escape(default_url)}"
    else
      default_url
    end
  end
end