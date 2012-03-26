require 'test_helper' 

describe HasMembers do
  it "have members" do
    group = create(:user, group: true)
    user = create(:user)
    Membership.create(resource: group, user: user)
    group.members.last.must_equal user
  end

  it "add members" do
    group = create(:user, group: true)
    user = create(:user)
    group.add_member(user)
    group.members.last.must_equal user
  end

  it "check membership" do
    group = create(:user, group: true)
    user = create(:user)
    group.member?(user).must_equal false
    group.add_member(user)
    group.member?(user).must_equal true
  end

  it "destroy all memberships" do
    group = create(:user, group: true)
    group.add_member(create(:user))
    group.add_member(create(:user))
    Membership.count.must_equal 2
    group.destroy
    Membership.count.must_equal 0
  end
end
