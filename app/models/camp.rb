# Camp
#
#create_table "camps", :force => true do |t|
#  t.string   "name",                :limit => 100 REQUIRED
#  t.string   "subdomain",           :limit => 100
#  t.string   "line1",               :limit => 200
#  t.string   "line2",               :limit => 200
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.string   "model_name",          :limit => 32
#  t.string   "origin",              :limit => 256
#  t.boolean  "show_media_on_lists",                :default => false
#end

class Camp < ActiveRecord::Base
  has_many :shelves
  has_many :shelf_items
  has_many :books
  has_many :comments
  has_many :bookmarks
  has_many :memberships
  has_many :users, through: :memberships
  has_many :versions
  has_many :posts

  validates :name, presence: true
end
