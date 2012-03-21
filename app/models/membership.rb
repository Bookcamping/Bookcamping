class Membership < ActiveRecord::Base
  belongs_to :resource, polymorphic: true
  belongs_to :user

  before_destroy do
    !owner?
  end
  
  def owner?
    resource.user_id == self.user_id
  end
end
