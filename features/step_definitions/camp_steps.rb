
Given /^a camp named "([^"]*)"$/ do |name|
  FactoryGirl.create(:camp, name: name)
end