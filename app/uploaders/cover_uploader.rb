class CoverUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :tags => ['cover']

  version :cover do
    process :resize_to_fit => [360,1000]
  end

  version :icon do
    process resize_to_pad: [100, 124, :transparent, 'south_east']
  end

  def public_id
    return "cover_#{model.id}"
  end
end
