Given /^a camp's shelf named "([^"]*)"$/ do |name|
  Given "a camp"
  @camp_shelf = CampShelf.find_by_name(name)
  @camp_shelf ||= FactoryGirl.create(:camp_shelf, name: name, camp: @camp)
end

Given /^a camp's shelf$/ do
  Given "a camp"
  @camp_shelf ||= FactoryGirl.create(:camp_shelf, camp: @camp)
end

