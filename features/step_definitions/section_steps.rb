Given /^a section named "([^"]*)"$/ do |name|
  FactoryGirl.create(:shelf, name: name)
end