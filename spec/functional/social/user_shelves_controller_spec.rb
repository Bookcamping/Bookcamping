require 'spec_helper'

feature 'show user shelves' do
  include RSpec::Rails::RequestExampleGroup
  background do
    FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user, name: 'Someone')
  end

  scenario 'show user shelves' do
    shelf = FactoryGirl.create(:user_shelf, user: @user, name: 'Una lista')

    visit user_user_shelves_path(@user)
    page.should have_content 'Una lista'
  end
end

