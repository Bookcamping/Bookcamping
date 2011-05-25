class Book < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :user
  has_many :comments, :as => :resource , :order => 'id DESC'
  has_many :shelf_items
  has_many :shelves, :through => :shelf_items

  scope :titled, where('title != null')

   has_paper_trail :meta => {
       :title => Proc.new {|book| book.title},
       :user_name => Proc.new{|book| book.user.name}
   }

  attr_accessible :description, :book_list_id, :title, :authors, :editor, :url
  attr_accessible :user_id, :as => :super

  validates :user_id, :presence => true
end
