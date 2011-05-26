class Book < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :comments, :as => :resource, :order => 'id DESC'
  has_many :shelf_items, :include => :shelf, :dependent => :destroy
  has_many :shelves, :through => :shelf_items

  scope :titled, where('title != null')

  has_paper_trail :meta => {
      :title => Proc.new { |book| book.title },
      :camp_id => Proc.new { |book| book.camp_id },
      :user_name => Proc.new { |book| book.user.name }
  }

  attr_accessible :description, :book_list_id, :title, :authors, :editor, :url, :date, :media
  attr_accessible :user_id, :as => :super

  validates :user_id, :presence => true
  validates :camp_id, :presence => true
end
