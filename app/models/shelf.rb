class Shelf < ActiveRecord::Base
  belongs_to :user
  has_many :shelf_items
  has_many :books, :through => :shelf_items

end
