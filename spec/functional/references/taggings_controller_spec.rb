require 'spec_helper'

feature 'Manager reference tags' do
  background do
    FactoryGirl.create :camp
    @user = FactoryGirl.create :user, rol: 'beta'
    @book = FactoryGirl.create :book
    visit enter_path(@user.id)
  end
  
  scenario 'Show reference tags' do
    @user.add_tag @book, 'tag1'
    @user.add_tag @book, 'tag2'
    visit book_path(@book)
    page.should have_content('Tag1')
    page.should have_content('Tag2')
  end

  scenario 'Add tag to reference' do
    visit book_path(@book)
    page.fill_in 'tag_name', with: 'My Tag'
    page.click_button 'submit_add_tag'
    page.should have_content('My tag')
    page.fill_in 'tag_name', with: 'tag2'
    page.click_button 'submit_add_tag'
    page.should have_content 'My tag'
    page.should have_content 'Tag2'
  end
end

