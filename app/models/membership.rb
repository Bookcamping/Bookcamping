class Membership < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user

  validates :camp_id, :presence => true
  validates :user_id, :presence => true

end
