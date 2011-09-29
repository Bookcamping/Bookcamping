
Given /^a camp named "([^"]*)"$/ do |name|
  @camp = FactoryGirl.create(:camp, name: name)
end

Given /^a camp$/ do
  @camp ||= FactoryGirl.create(:camp)
end

Given /^I'm at camp "([^"]*)"$/ do |name|
  @camp = Camp.find_by_name!(name)
  visit gocamp_path(@camp.id)
end