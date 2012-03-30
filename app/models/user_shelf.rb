class UserShelf < Shelf
  # EXTENSIONS
  extend FriendlyId
  has_paper_trail meta: {title: :name, camp_id: :camp_id}
  friendly_id :name, use: :slugged

  # VALIDATIONS
  validates :name, uniqueness: true

  # CALLBACKS
  after_create :add_owner_membership

  def add_reference(reference, user = nil)
    user ||= self.user
    add_reference_id(reference.id, user.id)
  end

  protected
  def add_owner_membership
    ShelfMember.create!(shelf_id: self.id, user_id: self.user_id)
  end

end

