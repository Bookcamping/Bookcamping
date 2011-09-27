Given /^a user named "([^"]*)"$/ do |name|
  Given "a camp"
  FactoryGirl.create(:user, name: name)
end