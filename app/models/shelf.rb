class Shelf < ActiveRecord::Base
  belongs_to :user
  has_many :shelf_items
  has_many :books, :through => :shelf_items


  def add_book(book, user)
    ShelfItem.create!(:shelf_id => self.id, :book_id => book.id, :user_id => user.id)
  end
end
