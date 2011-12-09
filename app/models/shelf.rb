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
  has_many :books, through: :shelf_items

  has_paper_trail :meta => {
      :title => Proc.new { |shelf| shelf.name },
      :camp_id => Proc.new { |shelf| shelf.camp_id },
      :user_name => Proc.new { |shelf| shelf.user.name }
  }

  # SCOPES
  scope :public, where(visibility: :public)
  scope :private, where(visibility: :private)

  # VALIDATIONS
  validates :user_id, presence: true
  validates :name, presence: true
  validates :visibility, presence: true

  # CALLBACKS
  before_save :clean_slug

  COLORS = ['#db533d', '#86475e', '#afa9ad', '#e9c54b', '#64a353',
            '#c36d3b', '#ee8587', '#357391', '#67c095', '#4eaea8', '#f15a5b',
            '#44adc6', '#9a7fba', '#e7de21', '#c1a574', '#d4d1c2', '#2f723e',
            '#a0a96a', '#f68b1f', '#a5932b', '#c14f52', '#738f57', '#e18256',
            '#dbb727', '#008eb0', '#967448', '#c2c76c']

  ROLES = []
  VISIBILITIES = [:private, :public]


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

  def add_book(book, user = nil)
    user ||= book.user
    add_reference(book.id, user.id)
  end

  protected
  def clean_slug
    self.slug = self.slug.parameterize if self.slug.present?
  end
  
  def add_reference(id, user_id)
    PaperTrail.enabled = false
    unless ShelfItem.where(shelf_id: self.id).where(book_id: id).first
      ShelfItem.create!(shelf: self, book_id: id, user_id: user_id)
    end
    PaperTrail.enabled = true
  end
end
