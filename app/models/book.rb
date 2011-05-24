class Book < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :user
  has_many :comments, :as => :resource , :order => 'id DESC'

  attr_accessible :description, :book_list_id
  attr_accessible :user_id, :as => :super

  validates :book_list_id, :presence => true
end
