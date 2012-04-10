class AvatarUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  #process :convert => 'png'
  process :tags => ['avatar']

  version :medium do
    process :resize_to_fit => [80,80]
  end

  version :small do
    process :resize_to_fit => [50, 50]
  end

  version :micro do
    process :resize_to_fit => [20, 20]
  end

  def public_id
    return "users/#{model.name}"
  end
end
