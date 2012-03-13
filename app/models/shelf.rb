# Shelf
#
# Una lista en bookcamping. Puede ser de varios tipos:
# CampShelf: una estantería. cada Camp(ing) tiene sus estanterías
# UserShelf: listas personales
#
class Shelf < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :shelf_items, dependent: :delete_all
  has_many :references, through: :shelf_items
  has_many :shelf_members, dependent: :delete_all
  has_many :members, class_name: 'User', through: :shelf_members, source: :user

  # EXTENSIONS
  has_paper_trail meta: {title: :name, camp_id: :camp_id}

  # SCOPES
  scope :public, where(visibility: :public)
  scope :private, where(visibility: :private)

  # VALIDATIONS
  validates :user_id, presence: true
  validates :name, presence: true
  validates :visibility, presence: true

  # CALLBACKS
  before_save :clean_slug

  ROLES = []
  VISIBILITIES = [:private, :public]

  # TODO: deprecate (self.members << user)
  def add_member(user)
    ShelfMember.create(shelf_id: self.id, user_id: user.id)
  end

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

  def visible_public?
    false
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
