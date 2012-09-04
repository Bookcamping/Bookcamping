# Shelf
#
# Una lista en bookcamping. Puede ser de varios tipos:
# CampShelf: una estantería. cada Camp(ing) tiene sus estanterías
# UserShelf: listas personales
#
class Shelf < ActiveRecord::Base
  # EXTENSIONS
  has_paper_trail meta: {title: :name, camp_id: :camp_id}
  include HasGroup
  include HasMembers
  store :settings, accessors: [:render_mode]
  MODES = ['icons', 'explanations']

  # RELATIONS
  belongs_to :camp
  belongs_to :user
  has_many :shelf_items, dependent: :delete_all
  has_many :references, through: :shelf_items
  has_many :versions, as: :item

  # VALIDATIONS
  validates :user_id, presence: true
  validates :name, presence: true

  def add_reference(reference, user = nil)
    user ||= reference.user
    add_reference_id(reference.id, user.id)
  end

  def collaborators
    memberships = Membership.where do
      (resource_type == 'Shelf' && resource_id == my{id}) |
        (resource_type == 'User' && resource_id == my{group_id} )
    end
    ids = memberships.map(&:user_id) << self.user_id
    User.where(id: ids)
  end

  def add_reference_id(id, user_id)
    PaperTrail.enabled = false
    unless ShelfItem.where(shelf_id: self.id).where(reference_id: id).first
      ShelfItem.create!(shelf: self, reference_id: id, user_id: user_id)
    end
    PaperTrail.enabled = true
  end
end
