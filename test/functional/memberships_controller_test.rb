require 'test_helper'

describe 'Memberships controller integration' do
  it 'search for non member users' do
    create(:camp)
    group = create(:user, group: true)
    group.add_member(create(:user, name: 'User 1'))
    create(:user, name: 'User 2')

    login_with group
    visit new_user_membership_path(group)
    fill_in 'user_name', with: 'User'
    click_submit 'search_member'
    page.text.must_include 'User 2'
    page.text.wont_include 'User 1'
  end
end
