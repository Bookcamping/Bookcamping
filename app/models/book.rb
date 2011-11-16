# Book - TODO: Rename to reference
#
# SCHEMA
#  create_table "books", :force => true do |t|
#    t.integer  "user_id" REQUIRED
#    t.integer  "camp_id" REQUIRED
#    t.integer  "license_id" REQUIRED
#    t.string   "title",            :limit => 300 REQUIRED
#    t.integer  "book_list_id"
#    t.string   "authors",          :limit => 100
#    t.string   "editor",           :limit => 100
#    t.text     "description"
#    t.string   "url",              :limit => 300
#    t.datetime "created_at"
#    t.datetime "updated_at"
#    t.integer  "comments_count",   :default => 0
#    t.string   "glasslevel",       :limit => 50
#    t.string   "license",          :limit => 50
#    t.string   "media",            :limit => 1024
#    t.string   "media_type",       :limit => 32
#    t.string   "date",             :limit => 40
#    t.string   "marks",            :limit => 300
#    t.integer  "like_it_marks",    :default => 0
#    t.integer  "read_later_marks", :default => 0
#  end
class Book < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :comments, :as => :resource, :order => 'id DESC', :dependent => :destroy

  has_many :shelf_items, :include => :shelf, :dependent => :destroy

  has_many :shelves, :through => :shelf_items
  has_many :camp_shelves, through: :shelf_items

  has_many :bookmarks, :dependent => :destroy
  belongs_to :license
  serialize :marks
  delegate :name, to: :license, prefix: true

  extend Camp::Scopes

  scope :titled, where('title != null')
  scope :search, lambda { |term| where('title LIKE ? OR authors LIKE ?', "%#{term}%", "%#{term}%") }

  has_paper_trail :meta => {
      :title => Proc.new { |book| book.title }
  }

  attr_accessible :description, :book_list_id, :title, :authors, :editor, :url, :date, :media, :license_id, :include_in_shelf_id
  attr_accessible :user_id, :as => :super
  attr_accessor :include_in_shelf_id

  validates :user_id, :presence => true
  validates :camp_id, :presence => true
  validates :title, :presence => true
  validates :license_id, :presence => true
  validates :include_in_shelf_id, presence: true, on: :create

  after_create do
    if include_in_shelf_id
      shelf = Shelf.find include_in_shelf_id
      shelf.add_book self, self.user
    end
  end

  RESOURCES = [:BookReference, :VideoReference]
  def resource_type
    RESOURCES[camp_id - 1]
  end

  def bookmark_count(name)
    self.send "#{name}_marks"
  end

  def update_bookmark(name, delta)
    attr = "#{name}_marks"
    if self.respond_to? attr
      PaperTrail.enabled = false
      value = self.send(attr) + delta
      self.update_attribute(attr, value)
      PaperTrail.enabled = true
    end
  end

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end


end

