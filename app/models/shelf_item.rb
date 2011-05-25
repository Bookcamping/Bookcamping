class ShelfItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :shelf
  belongs_to :book

  validates :user_id, :presence => true
  validates :shelf_id, :presence => true
  validates :book_id, :presence => true

  after_create :add_book_to_shelf
  after_destroy :remove_book_from_shelf

  protected
  def add_book_to_shelf
    shelf.update_attribute(:books_count, (shelf.books_count + 1))
  end

  def remove_book_from_shelf
    shelf.update_attribute(:books_count, (shelf.books_count - 1))
  end
end
