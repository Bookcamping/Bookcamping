class UserShelf < Shelf
  validates :name, uniqueness: {scope: [:user_id]}

  # EXTENSIONS
  has_paper_trail meta: {title: :name, camp_id: :camp_id}

  extend Shelf::ProfileScopes

  def add_reference(reference, user = nil)
    add_reference_id(reference.id, self.user.id)
  end
end

