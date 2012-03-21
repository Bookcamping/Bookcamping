require 'test_helper' 

describe HasMembers do
  it "have members" do
    camp = create(:camp)
    user = create(:user)
    Membership.create(resource: camp, user: user)
    camp.members.last.must_equal user
  end

  it "add members" do
    camp = create(:camp)
    user = create(:user)
    camp.add_member(user)
    camp.members.last.must_equal user
  end

  it "check membership" do
    camp = create(:camp)
    user = create(:user)
    camp.member?(user).must_equal false
    camp.add_member(user)
    camp.member?(user).must_equal true
  end

  it "add user as member when created" do
    camp = create(:camp)
    camp.members.count.must_equal 1
  end

  it "destroy all memberships" do
    camp = create(:camp)
    camp.add_member(create(:user))
    camp.add_member(create(:user))
    Membership.count.must_equal 3
    camp.destroy
    Membership.count.must_equal 0
  end
end
