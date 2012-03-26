require 'test_helper'

describe Membership do
  it "have resource and user" do
    group = create(:user, group: true)
    group.add_member(create(:user))
    group.memberships.first.resource.must_be :present?
    group.memberships.first.user.must_be :present?
  end

  it "can't have same user for same resource" do
    group = create(:user, group: true)
    member = create(:user)
    ms = Membership.create(resource: group, user: member)
    ms.save.must_equal true
    ms = Membership.create(resource: group, user: member)
    ms.save.must_equal false
  end
end
