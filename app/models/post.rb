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

  def public?
    self.visibility == 'public'
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def render_body(options = {})
    options.reverse_merge!(thumb: false)

    body.gsub /#\{MEDIA:\s*([^}]*)\s*}/ do
      media = MediaBite.find_by_id $1
      if media
        add_media_used(media)
        media.render_media(options)
      else
        "*{ERROR: Media '#{$1}' no encontrado!}*"
      end
    end
  end

  def add_media_used(media)
    @used_media ||= []
    @used_media << media
  end

  def used_media
    @used_media
  end

end
