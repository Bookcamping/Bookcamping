class UserShelf < Shelf
  validates :name, uniqueness: {scope: [:user_id]}

  def add_book(book)
    add_reference_id(book.id)
  end

  def add_reference_id(id)
    PaperTrail.enabled = false
    unless ShelfItem.where(shelf_id: self.id).where(book_id: id).first
      ShelfItem.create!(shelf: self, book_id: id, user: self.user)
    end
    PaperTrail.enabled = true
  end
end

