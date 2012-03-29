require 'test_helper'

describe UserMemberships do
  it "list memberships" do
    user = create(:user)
    shelf = create(:shelf)
    shelf.add_member(user)
    user.owned_memberships.count.must_equal 1
    user.owned_memberships.last.resource.must_equal shelf
  end

  it "has visible shelves" do
    user = create(:user)
    create(:camp_shelf, user: user)
    create(:user_shelf, user: user)
    create(:camp_shelf).add_member(user)
    create(:user_shelf).add_member(user)
    cs_ids = user.visible_camp_shelves.all.map(&:id)
    cs_ids.must_include 1
    cs_ids.must_include 3
    cs_ids.wont_include 2
    cs_ids.wont_include 4

    us_ids = user.visible_user_shelves.all.map(&:id)
    us_ids.must_include 2
    us_ids.must_include 4
    us_ids.wont_include 1
    us_ids.wont_include 3
  end
end
