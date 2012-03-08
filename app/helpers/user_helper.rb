module UserHelper
  include ActionView::Helpers::AssetTagHelper

  SIZES = {micro: 20, small: 40, medium: 80}
  def avatar_image(user, size = :medium)
    s = SIZES[size]
    s ||= 40
    image_tag(avatar_url(user, s), alt: user.name, width: s, height: s)
  end

  def avatar_url(user, s)
    default_url = "http://bookcamping.cc/images/guest#{s}x#{s}.png"
    if user.email.present?
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{s}&d=#{CGI.escape(default_url)}"
    else
      default_url
    end
  end
end
