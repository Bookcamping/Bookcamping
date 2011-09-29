# Media
#
# SCHEMA
# create_table :media do |t|
#   t.belongs_to :camp REQUIRED
#   t.belongs_to :user REQUIRED
#   t.string :title, limit: 200 REQUIRED
#   t.string :content_type, :limit => 32 REQUIRED
#   t.string :file, limit: 300
#   t.string :url, limit: 300
#   t.text :rendered
#   t.timestamps
# end
class Media < ActiveRecord::Base
  mount_uploader :file, MediaUploader

  belongs_to :camp
  belongs_to :user


  validates :camp_id, presence: true
  validates :user_id, presence: true
  validates :title, presence: true
  validates :content_type, presence: true
end
