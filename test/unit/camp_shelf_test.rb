require 'test_helper'

describe CampShelf do
  it "creates memberships" do
    camp = create(:camp_shelf)
    camp.add_member(create(:user))
    Membership.last.resource.must_equal camp
  end
end
