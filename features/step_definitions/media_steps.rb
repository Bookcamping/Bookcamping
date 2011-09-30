Given /^a media with title "([^"]*)" and "([^"]*)" is "([^"]*)"$/ do |title, column_name, column_value|
  Given "a camp"
  attributes = {title: title, camp: @camp}
  attributes[column_name.to_sym] = column_value
  @media = FactoryGirl.create(:media_bite, attributes)
end

Given /^a media with title "([^"]*)"$/ do |title|
  Given "a camp"
  @media = FactoryGirl.create(:media_bite, title: title, camp: @camp)
end