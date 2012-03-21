require 'test_helper'

describe Membership do
  it "can be owner" do
    camp = create(:camp)
    camp.memberships.first.must_be :owner?
    camp.add_member(create(:user))
    camp.memberships.last.wont_be :owner?
  end

  it "can't be destroyed if owner" do
    camp = create(:camp)
    owner = camp.memberships.first
    owner.destroy
    owner.wont_be :destroyed?
  end
end
