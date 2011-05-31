class Camp < ActiveRecord::Base
  has_many :shelves
  has_many :shelf_items
  has_many :books
  has_many :comments
  has_many :bookmarks
  has_many :memberships
  has_many :users, :through => :memberships
  has_many :versions
end
