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
  mount_uploader :content_file, MediaUploader

  belongs_to :camp
  belongs_to :user

  CONTENT_TYPES = ['file', 'url/link']

  validates :camp_id, presence: true
  validates :user_id, presence: true
  validates :title, presence: true
  #validates :content_type, presence: true

  def image_file?
    content_file.present? and content_file =~ /\.(?:jpg|jpeg|gif|png)$/
  end
end
