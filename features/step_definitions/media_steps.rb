Given /^a "([^"]*)" media with title "([^"]*)" and "([^"]*)" of "([^"]*)"$/ do |content_type, title, column_name, column_value|
  attributes = {title: title, content_type: content_type}
  attributes[column_name.to_sym] = column_value
  @media = FactoryGirl.create(:media_bite, attributes)
end