require 'spec_helper'

feature 'show users' do
  background do
    FactoryGirl.create(:camp)
  end

  scenario 'new user' do
    visit new_user_path
    within '#new_user' do
      fill_in 'user_name', :with => 'Bookcamping'
      fill_in 'user_email', :with => 'hola@bookcamping.cc'
      fill_in 'user_identities_attributes_0_password', :with => 'secret'
      click_button(:commit)
    end
    User.count.should == 1
    user = User.last
    current_path.should == user_path(user)
    user.identities.count.should == 1
    user.authorized_with?('secret').should == true
    find(:link, "current-user").has_content? 'Bookcamping'
  end

  scenario 'show all users' do
    1.upto(4) do |num|
      FactoryGirl.create(:user, name: "Usuario #{num}")
    end

    visit users_path
    1.upto(4) do |num|
      page.should have_content "Usuario #{num}"
    end
  end
end

