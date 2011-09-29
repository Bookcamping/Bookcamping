

local = ENV['S3_KEY'] ? {} : YAML::load(ERB.new(File.read("#{Rails.root}/config/amazon_s3.yml")).result)[Rails.env]

CarrierWave.configure do |config|
  config.s3_access_key_id = ENV['S3_KEY'] ? ENV['S3_KEY'] : local['access_key_id']
  config.s3_secret_access_key = ENV['S3_SECRET'] ? ENV['S3_SECRET'] : local['secret_access_key']
  config.s3_bucket = ENV['S3_BUCKET'] ? ENV['S3_BUCKET'] : local['bucket']
end