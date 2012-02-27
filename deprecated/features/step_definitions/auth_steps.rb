When /^I'm authenticated as "([^"]*)"$/ do |name|
  Given "a camp"
  @current_user = User.find_by_name name
  @current_user ||= FactoryGirl.create(:user, name: name)
  visit enter_path(@current_user.id)
end


When /^I'm an admin$/ do
  @current_user.update_attribute(:rol, 'admin')
end