When /^a license named "([^"]*)"$/ do |name|
  FactoryGirl.create(:license, name: name)
end