class Book < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :user

  validates :book_list_id, :presence => true
end
