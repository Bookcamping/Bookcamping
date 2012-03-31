require 'test_helper'

describe UserMemberships do
  it "has owned memberships" do
    user = create(:user)
    shelf = create(:shelf)
    shelf.add_member(user)
    user.owned_memberships.count.must_equal 1
    user.owned_memberships.last.resource.must_equal shelf
  end

  it "access owned shelves" do
    user = create(:user)
    visible = create(:user_shelf, user: user, hidden: false)
    hidden = create(:user_shelf, user: user, hidden: true)
    shelves = user.my_user_shelves
    shelves.must_include visible
    shelves.must_include hidden
  end

  it "access collaborated shelves" do
    user = create(:user)
    shelf = create(:user_shelf)
    shelf.add_member(user)
    shelves = user.my_user_shelves
    shelves.must_include shelf
  end

  it "access visible shelves" do
    user = create(:user)
    visible = create(:user_shelf, hidden: false)
    hidden = create(:user_shelf, hidden: true)
    shelves = user.visible_user_shelves
    shelves.must_include visible
    shelves.wont_include hidden
  end

  it "access hidden shelves if owned" do
    user = create(:user)
    hidden = create(:user_shelf, hidden: true, user: user)
    shelves = user.visible_user_shelves
    shelves.must_include hidden
  end

end
