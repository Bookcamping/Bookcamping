When /^I'm authenticated as "([^"]*)"$/ do |name|
  Given "a camp"
  user = User.find_by_name name
  user ||= FactoryGirl.create(:user, name: name)
  visit enter_path(user.id)
end