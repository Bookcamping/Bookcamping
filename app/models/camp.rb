class Camp < ActiveRecord::Base
  has_many :shelves
  has_many :shelf_items
  has_many :books
  has_many :comments
  has_many :versions
end
