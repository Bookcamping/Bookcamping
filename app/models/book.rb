class Book < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :user

  attr_accessible :description, :book_list_id
  attr_accessible :user_id, :as => :super

  validates :book_list_id, :presence => true
end
