require 'test_helper'

describe 'Users controller integration' do
  it "show user" do
    create(:camp)
    user = create(:user)
    visit user_path(user)
    page.text.must_include user.name
  end

  it "edit and update user profile" do
    create(:camp)
    user = login_with create(:user)
    visit edit_user_path(user)
    fill_in 'user_name', with: 'User name'
    fill_in 'user_email', with: 'user@email.com'
    fill_in 'user_twitter', with: 'usertwitter'
    fill_in 'user_description', with: 'User description'
    click_submit 'commit-profile'
    user.reload
    page.current_path.must_equal user_path(user)
    user.name.must_equal 'User name'
    user.email.must_equal 'user@email.com'
    user.twitter.must_equal 'usertwitter'
    user.description.must_equal 'User description'
  end

  it "convert regular user to a group" do
    create(:camp)
    user = create(:user, group: false)
    login_with(user)
    visit edit_user_path(user)
    click_submit 'commit-group'
    user.reload
    user.group.must_equal true
  end

  it "create a new group" do
    create(:camp)
    user = create(:user)
    login_with(user)
    visit user_path(user)
    page.find('a[rel=new-group]').click
    fill_in 'user_name', with: 'Grupo'
    fill_in 'user_email', with: 'grupo@email.com'
    click_submit
    group = User.last
    group.name.must_equal 'Grupo'
    group.email.must_equal 'grupo@email.com'
    group.must_be :group?
  end
end
