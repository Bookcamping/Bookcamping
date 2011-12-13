require 'spec_helper'

feature 'User activity:' do
  background do
    FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user)
  end

  scenario 'show user activity' do
    book = FactoryGirl.create(:book, user: @user)
    visit user_versions_path(@user)
    page.should have_content book.title
  end
end

