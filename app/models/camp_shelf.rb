# CampShelf
#
# CampShelf es una estantería, es decir, una lista asociada a un Camp(ing)
class CampShelf < Shelf
  include Extensions::Slug
  extend Camp::Scopes

  has_slug nil
  has_paper_trail :meta => {
    :item_type => 'CampShelf',
    :title => Proc.new { |shelf| shelf.name },
    :camp_id => Proc.new { |shelf| shelf.camp_id }
  }



  validates :camp_id, presence: true
  validates :slug, presence: true

  # Callbacks
  before_save :clean_slug

  def visible_public?
    self.visibility == 'public'
  end
end

