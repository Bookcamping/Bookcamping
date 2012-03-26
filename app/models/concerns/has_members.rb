module HasMembers
  extend ActiveSupport::Concern

  included do
    has_many :memberships, as: :resource, dependent: :delete_all
    has_many :members, through: :memberships, class_name: 'User', source: :user
  end

  def add_member(user)
    Membership.create(resource: self, user: user)
  end

  def member?(user)
    Membership.where(resource_type: self.class.name, resource_id: self.id, 
                     user_id: user.id).first.present?
  end
end
