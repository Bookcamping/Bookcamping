require 'test_helper'

describe 'Memberships controller integration' do
  before do
    create(:camp)
  end

  it 'show members' do
    owner = create(:user, name: 'Owner')
    group = create(:user, group: true)
    group.add_member(create(:user, name: 'Groupr'))
    list = create(:user_shelf, user: owner, group: group)
    list.add_member(create(:user, name: 'Collaborator'))
    visit user_shelf_memberships_path(list)
    page.text.must_include 'Owner'
    page.text.must_include 'Groupr'
    page.text.must_include 'Collaborator'
  end

  it 'search for non member users' do
    group = create(:user, group: true)
    group.add_member(create(:user, name: 'User 1'))
    owner = create(:user, name: 'User 2')
    shelf = create(:user_shelf, user: owner, group: group)
    create(:user, name: 'User 3')

    login_with shelf.user
    visit user_shelf_memberships_path(shelf)
    fill_in 'user_name', with: 'User'
    click_submit 'search_member'
    find('.search_results').text.must_include 'User 3'
    find('.search_results').text.wont_include 'User 1'
    find('.search_results').text.wont_include 'User 2'
  end

  it "groups have memberships" do
    user = create(:user, group: true)
    visit user_memberships_path(user)
  end
end
