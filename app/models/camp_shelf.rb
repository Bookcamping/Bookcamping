# CampShelf
#
# CampShelf es una estantería, es decir, una lista asociada a un Camp(ing)
class CampShelf < Shelf
  # EXNTESIONS
  extend FriendlyId
  friendly_id :slug

  #has_slug nil


  validates :camp_id, presence: true
  validates :slug, presence: true
end

