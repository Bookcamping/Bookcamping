# Publisher
#
class Publisher < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :references

  validates :name, presence: true, uniqueness: true

  def add_reference(reference)
    reference.update_attribute(:publisher_id, self.id) if reference.publisher_id.blank?
  end
end
