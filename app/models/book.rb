class Book < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :user

end
