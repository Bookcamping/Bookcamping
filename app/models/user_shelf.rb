class UserShelf < Shelf
  # EXTENSIONS
  extend FriendlyId
  has_paper_trail meta: {title: :name, camp_id: :camp_id}
  friendly_id :name, use: :slugged

  # VALIDATIONS
  validates :name, uniqueness: true

  def add_reference(reference, user = nil)
    user ||= self.user
    add_reference_id(reference.id, user.id)
  end
end

