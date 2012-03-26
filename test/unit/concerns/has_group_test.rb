require 'test_helper'

describe HasGroup do
  it "can have a group" do
    camp = create(:camp)
    camp.group.must_be :blank?
    camp.group = create(:user, group: true)
    camp.save.must_equal true
    camp.reload
    camp.group.must_be :present?
  end

  it "have group members" do
    group = create(:user, group: true)
    group.add_member(create(:user))
    group.add_member(create(:user))
    camp = create(:camp, group: group)
    camp.group_members.size.must_equal 2
  end

  it "checks member?" do
    group = create(:user, group: true)
    user = create(:user)
    group.add_member(user)
    camp = create(:camp, group: group)

    camp.member?(camp.user).must_equal true
    camp.member?(user).must_equal true
    camp.member?(create(:user)).must_equal false
  end
end
