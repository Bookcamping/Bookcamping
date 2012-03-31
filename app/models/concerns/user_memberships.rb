module UserMemberships
  extend ActiveSupport::Concern

  included do
    has_many :owned_memberships, class_name: 'Membership'
  end

  def my_user_shelves
    my_shelves_scoped_by(UserShelf)
  end

  def visible_camp_shelves
    visible_shelves_scoped_by(CampShelf)
  end

  def visible_user_shelves
    visible_shelves_scoped_by(UserShelf)
  end

  private
  def my_shelves_scoped_by(scope)
    ids = Membership.where(resource_type: 'Shelf', user_id: id).map(&:resource_id)
    scope.where { user_id.eq(my{id}) | id.in(ids) }
  end

  def visible_shelves_scoped_by(scope)
    ids = Membership.where(resource_type: 'Shelf', user_id: id).map(&:resource_id)
    scope.where { hidden.eq(false) | user_id.eq(my{id}) }
  end
end
