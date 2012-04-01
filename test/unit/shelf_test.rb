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
    owner = create(:user, name: 'owner')
    group = create(:user, group: true, name: 'group')
    group_member = create(:user, name: 'member')
    group.add_member(group_member)
    shelf = create(:shelf, user: owner, group: group)
    shelf_member = create(:user, name: 'collab')
    shelf.add_member(shelf_member)

    c = shelf.collaborators
    c.size.must_equal 3
    c.must_include owner
    c.must_include group_member
    c.must_include shelf_member
  end
end

