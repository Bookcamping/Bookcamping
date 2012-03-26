class Membership < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :user

  validates :resource_id, presence: true
  validates :resource_type, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:resource_id, :resource_type]
end
