# encoding: utf-8
require 'test_helper'

describe "User shelves controller integration" do
  before do
    create(:camp)
  end

  it "index should show shelves names" do
    create(:user_shelf, name: 'Lista 1')
    create(:user_shelf, name: 'Lista 2')
    visit user_shelves_path
    page.text.must_include 'Lista 1'
    page.text.must_include 'Lista 2'
  end

  it "index shold show shelf information" do
    owner = create(:user, name: 'Owner')
    group = create(:user, name: 'Group')
    shelf = create(:user_shelf, user: owner, group: group)
    shelf.add_member(create(:user))

    visit user_shelves_path
    page.text.must_include 'Owner'
    page.text.must_include 'Group'
    page.text.must_include '1 más'
  end

  it "can create a new shelf" do
    user = create(:user)
    login_with user
    visit new_user_shelf_path
    fill_in 'user_shelf_name', with: 'Lista'
    click_submit
    shelf = UserShelf.last
    shelf.name.must_equal 'Lista'
    shelf.user.must_equal user
  end

  it "collaborators can add reference" do
    user = create(:user)
    group = create(:user, group: true)
    group.add_member(user)
    shelf = create(:user_shelf, group: group)
    visit user_shelf_path(shelf)
    page.find('a[rel=add-reference]').click
  end
end
