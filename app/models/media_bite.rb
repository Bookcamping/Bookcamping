# Media
#
# SCHEMA
# create_table :media do |t|
#    t.belongs_to :camp
#    t.belongs_to :user
#    t.string :title, limit: 200
#    t.string :content_type, limit: 32
#    t.string :file_content, limit: 300
#    t.string :render_as, limit: 32
#    t.string :position, limit: 16
#    t.integer :width
#    t.integer :height
#    t.string :url_content, limit: 300
#    t.text :text_content
#    t.timestamps
# end
class MediaBite < ActiveRecord::Base
  mount_uploader :file_content, MediaUploader

  belongs_to :camp
  belongs_to :user

  CONTENT_TYPES = ['file', 'url/link']
  POSITIONS = [:left, :center, :right]

  validates :camp_id, presence: true
  validates :user_id, presence: true
  validates :title, presence: true
  #validates :content_type, presence: true

  def image_file?
    file_content.present? and file_content_url =~ /\.(?:jpg|jpeg|gif|png)$/
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def render_media(options)
    if image_file?
      url = options[:thumb] ? file_content.url(:thumb) : file_content.url
      img = "<img src='#{url}' alt='#{title}' class='#{position}'/>"
      if link.present?
        "<a href='#{link}'>#{img}</a>"
      end
    else
      "<a href='#'>#{title}</a>"
    end
  end

  def inline_code
    "#\{MEDIA:#{to_param}}"
  end

end
