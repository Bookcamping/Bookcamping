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

  # RELATIONS
  belongs_to :camp
  belongs_to :user
  has_many :shelf_items, dependent: :delete_all
  has_many :references, through: :shelf_items

  # VALIDATIONS
  validates :user_id, presence: true
  validates :name, presence: true

  # CALLBACKS
  before_save :clean_slug

  # TODO: deprecate
  def background
    color? ? color : '#db533d'
  end

  def to_param
    if slug.present?
      slug.parameterize
    else
      limited = name.split[0..2].join(' ')
      "#{self.id}-#{limited.parameterize}"
    end
  end

  def add_reference(reference, user = nil)
    user ||= reference.user
    add_reference_id(reference.id, user.id)
  end

  protected
  def clean_slug
    self.slug = self.slug.parameterize if self.slug.present?
  end
  
  def add_reference_id(id, user_id)
    PaperTrail.enabled = false
    unless ShelfItem.where(shelf_id: self.id).where(reference_id: id).first
      ShelfItem.create!(shelf: self, reference_id: id, user_id: user_id)
    end
    PaperTrail.enabled = true
  end
end
