require 'spec_helper'

feature 'User activity:' do
  background do
    FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user)
  end

  scenario 'show user activity' do
    reference = FactoryGirl.create(:reference, user: @user)
    visit user_versions_path(@user)
    page.should have_content reference.title
  end
end

