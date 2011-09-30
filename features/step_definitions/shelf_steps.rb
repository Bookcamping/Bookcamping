Given /^a shelf$/ do
  Given "a camp"
  @shelf ||= FactoryGirl.create(:shelf, camp: @camp)
end

# CAMP
Given /^a camp's shelf$/ do
  Given "a camp"
  @camp_shelf ||= FactoryGirl.create(:camp_shelf, camp: @camp)
end

Given /^a camp's shelf named "([^"]*)"$/ do |name|
  Given "a camp"
  @camp_shelf = CampShelf.find_by_name(name)
  @camp_shelf ||= FactoryGirl.create(:camp_shelf, name: name, camp: @camp)
end

# CURATED
When /^a curated shelf named "([^"]*)"$/ do |name|
  Given "a camp"
  @curated_shelf = CuratedShelf.find_by_name name
  @curated_shelf ||= FactoryGirl.create(:curated_shelf, name: name, camp: @camp)
end

# USER
Given /^a user's shelf named "([^"]*)"$/ do |name|
    Given "a camp"
    @user_shelf = UserShelf.find_by_name(name)
    @user_shelf ||= FactoryGirl.create(:user_shelf, name: name, camp: @camp)
end

