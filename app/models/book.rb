# Book - TODO: Rename to reference
#
class Book < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :comments, :as => :resource, :order => 'id DESC', :dependent => :destroy

  has_many :shelf_items, :include => :shelf, :dependent => :destroy

  has_many :shelves, :through => :shelf_items
  has_many :camp_shelves, through: :shelf_items

  has_many :taggins, foreign_key: :reference_id
  has_many :tags, through: :taggins

  has_many :bookmarks, :dependent => :destroy
  belongs_to :license
  serialize :marks
  delegate :name, to: :license, prefix: true

  extend Camp::Scopes

  scope :titled, where('title != null')
  scope :search, lambda { |term| where('title LIKE ? OR authors LIKE ?', "%#{term}%", "%#{term}%") }

  # SERVICES
  has_paper_trail :meta => {
      :title => Proc.new { |book| book.title }
  }

  # ATTRIBUTES
  attr_accessible :description, :book_list_id, :title, :authors, :editor, :url, :date, :media, :license_id, :include_in_shelf_id
  attr_accessible :user_id, :as => :super
  attr_accessor :include_in_shelf_id

  # VALIDATIONS
  validates :user_id, :presence => true
  validates :camp_id, :presence => true
  validates :title, :presence => true
  validates :license_id, :presence => true
  # validates :include_in_shelf_id, presence: true, on: :create

  after_create do
    if include_in_shelf_id
      shelf = Shelf.find include_in_shelf_id
      shelf.add_book self, self.user
    end
  end

  RESOURCES = [:BookReference, :VideoReference, :EscuchaReference]
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

