require 'test_helper'

describe Shelf do
  it "requires name and user" do
    shelf = create(:shelf)
    shelf.name.must_be :present?
    shelf.user.must_be :present?
  end

  it "create versions" do
    shelf = create(:shelf)
    v = Version.last
    v.item_type.must_equal 'Shelf'
    v.item_id.must_equal shelf.id
  end

  it "have members" do
    shelf = create(:shelf)
    shelf.add_member(create(:user))
    shelf.memberships.count.must_equal 1
  end

  it "have collaborators" do
    group = create(:user, group: true)
    group.add_member(create(:user, name: 'group-user'))
    shelf = create(:shelf, group: group)
    shelf.add_member(create(:user, name: 'collaborator'))

    c = shelf.collaborators.map(&:id)
    c.size.must_equal 3
    c.must_include shelf.user.id
    c.must_include group.members.first.id
    c.must_include shelf.members.first.id
  end
end

