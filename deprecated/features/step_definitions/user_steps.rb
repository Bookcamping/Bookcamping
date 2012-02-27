Given /^a user named "([^"]*)"$/ do |name|
  Given "a camp"
  @user = FactoryGirl.create(:user, name: name)
end
