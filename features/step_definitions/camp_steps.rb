
Given /^a camp named "([^"]*)"$/ do |name|
  @camp = FactoryGirl.create(:camp, name: name)
end

Given /^a camp$/ do
  @camp ||= FactoryGirl.create(:camp)
end