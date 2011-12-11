require 'spec_helper'

feature "should admin camps" do
  background do
    FactoryGirl.create(:camp)
  end
 
  scenario "should have index" do
    get admin_camps_path
    response.should be_success
  end

end
