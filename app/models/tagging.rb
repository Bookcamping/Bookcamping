class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
  belongs_to :reference, class_name: 'Reference'

  # VALIDATIONS
  validates :tag_id, presence: true
  validates :user_id, presence: true
  validates :reference_id, presence: true
  validates_uniqueness_of :reference_id, scope: :tag_id

  after_create do
    self.tag.increment_size
  end

  after_destroy do
    self.tag.decrement_size
  end
end
