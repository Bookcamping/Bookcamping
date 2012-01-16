class UserShelf < Shelf
  validates :name, uniqueness: {scope: [:user_id]}

  has_paper_trail meta: {title: :name, camp_id: :camp_id}

  extend Shelf::ProfileScopes
  
  def add_book(book, user = nil)
    add_reference_id(book.id, self.user.id)
  end
end

