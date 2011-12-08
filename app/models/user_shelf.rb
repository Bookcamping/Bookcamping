class UserShelf < Shelf
  validates :name, uniqueness: {scope: [:user_id]}

  extend Shelf::ProfileScopes
  
  def add_book(book)
    add_reference_id(book.id, self.user.id)
  end
end

