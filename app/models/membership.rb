class Membership < ActiveRecord::Base
  # EXTENSIONS
  has_paper_trail meta: {
    title: Proc.new {|m| "#{m.user.name} a '#{m.resource.name}'"}
  }

  # RELATIONS
  belongs_to :resource, polymorphic: true, counter_cache: true
  belongs_to :user

  # VALIDATIONS
  validates :resource_id, presence: true
  validates :resource_type, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:resource_id, :resource_type]
end
