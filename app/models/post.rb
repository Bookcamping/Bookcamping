# Post
#
# SCHEMA
#  create_table "posts", :force => true do |t|
#    t.integer  "camp_id" REQUIRED
#    t.integer  "user_id" REQUIRED
#    t.string   "author",     :limit => 100 REQUIRED
#    t.string   "title",      :limit => 300 REQUIRED
#    t.string   "visibility",      :limit => 16 REQUIRED
#    t.datetime "published_at"
#    t.text     "body"
#    t.datetime "created_at"
#    t.datetime "updated_at"
#  end
#
class Post < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user

  scope :public, where(visibility: 'public')

  VISIBILITIES = [:draft, :private, :public]

  validates :camp_id, presence: true
  validates :user_id, presence: true
  validates :author, presence: true
  validates :title, presence: true
  validates :visibility, presence: true

  def to_param
    "#{id}-#{title.parameterize}"
  end

end
