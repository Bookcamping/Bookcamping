require 'spec_helper'

feature "should admin camps" do
  background do
    FactoryGirl.create(:camp, name: 'Camping')
  end
 
  scenario "should have index" do
    visit admin_camps_path
    page.should have_content('Camping')
  end

end
