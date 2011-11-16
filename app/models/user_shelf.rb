class UserShelf < Shelf
  validates :name, uniqueness: {scope: [:user_id, :camp_id]}

  def add_book(book)
    ShelfItem.create!(shelf: self, book: book, user: self.user)
  end
end

