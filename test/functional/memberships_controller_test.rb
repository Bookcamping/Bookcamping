require 'test_helper'

describe 'Memberships controller integration' do
  it 'show members' do
    create(:camp)
    group = create(:user, group: true)
    group.add_member(create(:user, name: 'Username'))
    login_with group
    visit user_memberships_path(group)
    page.text.must_include 'Username'
  end

  it 'search for non member users' do
    create(:camp)
    group = create(:user, group: true)
    group.add_member(create(:user, name: 'User 1'))
    create(:user, name: 'User 2')

    login_with group
    visit user_memberships_path(group)
    fill_in 'user_name', with: 'User'
    click_submit 'search_member'
    find('.search_results').text.must_include 'User 2'
    find('.search_results').text.wont_include 'User 1'
  end
end
