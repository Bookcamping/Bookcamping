class Book < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :comments, :as => :resource, :order => 'id DESC', :dependent => :destroy
  has_many :shelf_items, :include => :shelf, :dependent => :destroy
  has_many :shelves, :through => :shelf_items
  has_many :bookmarks, :dependent => :destroy
  belongs_to :license
  serialize :marks

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


  after_create do
    shelf = Shelf.find include_in_shelf_id
    shelf.add_book self, self.user
  end

  def bookmark_count(name)
    self.send "#{name}_marks"
  end

  def update_bookmark(name, delta)
    value = self.send("#{name}_marks") + delta
    self.update_attribute("#{name}_marks", value)
  end

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end


end
