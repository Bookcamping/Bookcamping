class BookList < ActiveRecord::Base
  belongs_to :user
  has_many :books
  acts_as_list

end
