Given /^a blog post titled "([^"]*)"$/ do |title|
  Given "a camp"
  FactoryGirl.create(:post, title: title, camp: @camp)
end
