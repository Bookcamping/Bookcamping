require 'test_helper'

describe UserMemberships do
  it "has owned memberships" do
    user = create(:user)
    shelf = create(:shelf)
    shelf.add_member(user)
    user.owned_memberships.count.must_equal 1
    user.owned_memberships.last.resource.must_equal shelf
  end

  it "visible_shelves include all if admin" do
    user = create(:user, rol: 'admin')
    shelf = create(:user_shelf, hidden: true)
    user.visible_user_shelves.must_include shelf
  end

  it "my_shelves include group shelves" do
    user = create(:user, group: true)
    grouped = create(:user_shelf, group: user)
    user.my_user_shelves.must_include grouped
  end

  it "my_shelves doesn't include other's shelves" do
    user = create(:user)
    shelf = create(:user_shelf)
    user.my_user_shelves.wont_include shelf
  end

  it "my_shelves include owned shelves" do
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
