# CampShelf
#
# CampShelf es una estantería, es decir, una lista asociada a un Camp(ing)
class CampShelf < Shelf
  # EXNTESIONS
  extend FriendlyId
  friendly_id :slug
  has_paper_trail meta: {title: :name, camp_id: :camp_id}
  include Extensions::Slug
  extend Camp::Scopes

  #has_slug nil


  validates :camp_id, presence: true
  validates :slug, presence: true

  # Callbacks
  before_save :clean_slug

end

