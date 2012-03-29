module HasGroup
  extend ActiveSupport::Concern

  included do
    belongs_to :group, class_name: 'User'
    delegate :members, to: :group, allow_nil: true, prefix: true
  end

  def member?(user)
    (self.user_id == user.id) ||
      (self.group_id.present? && self.group.member?(user))
  end

end
