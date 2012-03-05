class UserShelf < Shelf
  extend FriendlyId


  # VALIDATIONS
  validates :name, uniqueness: true

  # EXTENSIONS
  has_paper_trail meta: {title: :name, camp_id: :camp_id}
  friendly_id :name, use: :slugged

  extend Shelf::ProfileScopes

  # CALLBACKS
  after_create :add_owner_membership

  def add_reference(reference, user = nil)
    add_reference_id(reference.id, self.user.id)
  end

  protected
  def add_owner_membership
    ShelfMember.create!(shelf_id: self.id, user_id: self.user_id)
  end

end

