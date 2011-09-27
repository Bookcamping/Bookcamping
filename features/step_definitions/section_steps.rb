Given /^a section named "([^"]*)"$/ do |name|
  Given "a camp"
  FactoryGirl.create(:shelf, name: name, camp: @camp)
end

