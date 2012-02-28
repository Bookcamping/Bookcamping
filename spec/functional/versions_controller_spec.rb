require 'spec_helper'

feature 'View site activity' do
  background do
    @camp = FactoryGirl.create(:camp, name: 'testcamping')
  end

  scenario 'view reference activity' do
    PaperTrail.controller_info = {user_name: 'my_name'}
    reference = FactoryGirl.create(:reference, title: 'My reference')
    visit versions_path
    page.should have_content 'My reference'
  end
end

