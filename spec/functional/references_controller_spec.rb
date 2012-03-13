require 'spec_helper'

feature 'References controller' do
  background do
    @camp = FactoryGirl.create(:camp, name: 'testcamping')
  end

  scenario 'search references' do
    Factory.create :reference, title: 'Mi libro'
    visit '/'
    page.should have_field 'term'
    page.fill_in 'term', with: 'libr'
    page.click_button 'submit-search'
    page.should have_content 'Mi libro'
  end

  scenario 'view reference' do
    user = Factory :user
    visit enter_path(user.id)
    reference = Factory.create :reference, title: 'Mi libro', user: user
    visit reference_path(reference)
    page.should have_content 'Mi libro'
  end
end
