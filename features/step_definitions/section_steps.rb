Given /^a section named "([^"]*)"$/ do |name|
  Given "a camp"
  @section = Section.find_by_name(name)
  @section ||= FactoryGirl.create(:shelf, name: name, camp: @camp)
end

Given /^a section/ do
  Given "a camp"
  @section ||= FactoryGirl.create(:shelf, camp: @camp)
end

