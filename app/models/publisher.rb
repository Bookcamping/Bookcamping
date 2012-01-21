# Publisher
#
class Publisher < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  before_save do 
    self.slug = self.slug.parameterize
  end
end
