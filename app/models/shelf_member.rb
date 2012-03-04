# A member of a shelf (currently only on user shelves)
class ShelfMember < ActiveRecord::Base
  belongs_to :shelf, counter_cache: :shelf_members_count
  belongs_to :user

  # VALIDATIONS
  validates :shelf_id, presence: true
  validates :user_id, presence: true
end
