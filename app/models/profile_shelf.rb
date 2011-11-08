# ProfileShelf
#
# Predefined user shelves. Currently like_it and read_later
# Has different behaviour (for example: they update some statistics 
# on references) and can't be deleted by user
#
class ProfileShelf < Shelf
  validates :rol, presence: true

  ROLES = [:like_it, :read_later]
  TO_PARAM = {'like_it' => 'favoritos', 'read_later' => 'para_leer'}

  def add_book(book, user)
    ShelfItem.create!(shelf: self, book: book, user: user)
    PaperTrail.enabled = false
    self.book.update_bookmark(self.name, 1)
    PaperTrail.enabled = true
  end

  def remove_book(book, user)
  end

  def to_param
    TO_PARAM[self.rol]
  end

end
