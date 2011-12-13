require 'spec_helper'

feature 'View site activity' do
  background do
    @camp = FactoryGirl.create(:camp, name: 'testcamping')
  end

  scenario 'view reference activity' do
    PaperTrail.controller_info = {user_name: 'my_name'}
    book = FactoryGirl.create(:book, title: 'My book')
    visit versions_path
    page.should have_content 'My book'
  end
end

