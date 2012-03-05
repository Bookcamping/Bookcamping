# Reference
#
class Reference < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :comments, :as => :resource, :order => 'id DESC', :dependent => :destroy

  # TAGS
  has_many :taggings, dependent: :destroy, foreign_key: 'reference_id'
  has_many :tags, through: :taggings

  has_many :shelf_items, :include => :shelf, :dependent => :destroy

  has_many :shelves, :through => :shelf_items
  has_many :camp_shelves, through: :shelf_items

  belongs_to :license, counter_cache: true
  serialize :marks

  delegate :name, to: :license, prefix: true

  extend Camp::Scopes

  scope :titled, where('title != null')
  scope :search, lambda { |term| where('title LIKE ? OR authors LIKE ?', "%#{term}%", "%#{term}%") }

  # EXTENSIONS
  has_paper_trail meta: {title: :title, camp_id: :camp_id}

  # ATTRIBUTES
  attr_accessible :description, :reference_list_id, :title, :authors, :editor, :url, :date, :media, :license_id, :include_in_shelf_id
  attr_accessible :user_id, :as => :super
  attr_accessor :include_in_shelf_id

  # VALIDATIONS
  validates :user_id, :presence => true
  validates :camp_id, :presence => true
  validates :title, :presence => true
  validates :license_id, :presence => true
  validates :ref_type, :presence => true
  # validates :include_in_shelf_id, presence: true, on: :create

  REF_TYPES = ['Book', 'Video', 'Audio', 'WebPage']

  after_create do
    if include_in_shelf_id.present?
      shelf = Shelf.find include_in_shelf_id
      shelf.add_reference self, self.user
    end
  end

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end


end

