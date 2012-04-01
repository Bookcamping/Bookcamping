require 'test_helper'

describe 'Users controller integration' do
  before do
    create(:camp)
  end

  it "show user" do
    user = create(:user)
    my_ref = create(:reference)
    user.add_reference(my_ref)

    visit user_path(user)
    page.text.must_include user.name
    page.text.must_include my_ref.title
  end

  it "create new user" do
    login_with nil
    visit new_user_path
    fill_in 'user_name', with: 'NewUser'
    fill_in 'user_email', with: 'newuser@example.com'
    fill_in 'user_password', with: 'secret'
    fill_in 'user_password_confirmation', with: 'secret'
    click_submit
    u = User.last
    u.name.must_equal 'NewUser'
    u.email.must_equal 'newuser@example.com'
  end

  it "show user user_shelves" do
    user = create(:user)
    shelf = create(:user_shelf)
    owned = create(:user_shelf, user: user)
    shared = create(:user_shelf)
    shared.add_member(user)

    visit user_path(user)
    page.text.wont_include shelf.name
    page.text.must_include owned.name
    page.text.must_include shared.name
  end

  it "edit and update user profile" do
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
    user = create(:user, group: false)
    login_with(user)
    visit edit_user_path(user)
    click_submit 'commit-group'
    user.reload
    user.group.must_equal true
  end

  it "create a new group" do
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

  it "searches" do
    create(:user, name: 'Silvink')
    visit users_path
    fill_in 'term', with: 'Sil'
    click_submit 'commit-search-user'
    find('.search-results').text.must_include 'Silvink'
    puts find('.search-results').text
  end
end
