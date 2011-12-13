# encoding: utf-8
require 'spec_helper'

feature 'show user shelves' do
  background do
    FactoryGirl.create(:camp)
    @user = FactoryGirl.create(:user)
    visit enter_path(@user.id)
  end
  
  scenario 'show all user shelves' do
    FactoryGirl.create(:user_shelf, user: @user, name: 'Lista pública')
    FactoryGirl.create(:user_shelf, user: @user, name: 'Lista privada', visibility: 'private')

    visit personal_user_shelves_path
    page.should have_content 'Lista pública'
    page.should have_content 'Lista privada'
  end

  scenario 'show empty shelf' do
    shelf = FactoryGirl.create(:user_shelf, user: @user, name: 'Empty')
    visit personal_user_shelf_path(shelf)
    page.should have_content 'Empty'
  end

  scenario 'show user shelf references' do
    shelf = FactoryGirl.create(:user_shelf, user: @user, name: 'Lista1')
    shelf.add_book FactoryGirl.create(:book, user: @user)
    visit personal_user_shelf_path(shelf)
    page.should have_content 'Lista1'
  end
end
