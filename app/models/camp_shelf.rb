# CampShelf
#
# CampShelf es una estantería, es decir, una lista asociada a un Camp(ing)
class CampShelf < Shelf

  extend Camp::Scopes

  validates :camp_id, presence: true

  def add_book(book, user)
    ShelfItem.create!(shelf: self, book: book, user: user)
  end


  def visible_public?
    self.visibility == 'public'
  end
end

