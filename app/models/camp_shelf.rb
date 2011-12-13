# CampShelf
#
# CampShelf es una estantería, es decir, una lista asociada a un Camp(ing)
class CampShelf < Shelf
  include Extensions::Slug
  extend Camp::Scopes

  has_slug nil

  has_paper_trail meta: {title: :name, camp_id: :camp_id,
                         extra: 'CampShelf'}

  validates :camp_id, presence: true
  validates :slug, presence: true

  # Callbacks
  before_save :clean_slug

  def visible_public?
    self.visibility == 'public'
  end
end

