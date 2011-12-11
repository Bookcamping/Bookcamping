# CampShelf
#
# CampShelf es una estantería, es decir, una lista asociada a un Camp(ing)
class CampShelf < Shelf

  extend Camp::Scopes

  validates :camp_id, presence: true

  # Callbacks
  before_save :clean_slug

  def visible_public?
    self.visibility == 'public'
  end

  protected
  def clean_slug
    self.slug = self.slug.parameterize
  end

end

