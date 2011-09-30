Given /^a user's shelf named "([^"]*)"$/ do |name|
    Given "a camp"
    @user_shelf = UserShelf.find_by_name(name)
    @user_shelf ||= FactoryGirl.create(:user_shelf, name: name, camp: @camp)
end