module UserMemberships
  extend ActiveSupport::Concern

  included do
    has_many :owned_memberships, class_name: 'Membership'
  end

  def visible_camp_shelves
    visible_shelves_scoped(CampShelf)
  end

  def visible_user_shelves
    visible_shelves_scoped(UserShelf)
  end

  private
  def visible_shelves_scoped(scope)
    ids = Membership.where(resource_type: 'Shelf', user_id: id).map(&:resource_id)
    scope.where { id.in(ids) | user_id.eq(my{id}) }
  end
end
