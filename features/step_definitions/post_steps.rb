Given /^a blog post titled "([^"]*)"$/ do |title|
  Given "a camp"
  @post = FactoryGirl.create(:post, title: title, camp: @camp)
end

When /^last post is "([^"]*)"$/ do |visibility|
  @post.update_attribute(:visibility, visibility)
end

Given /^a post with title "([^"]*)" and "([^"]*)" is "([^"]*)"$/ do |title, attr, value|
  Given "a camp"
  attributes = {title: title, camp: @camp}
  attributes[attr.to_sym] = value
  @post = FactoryGirl.create(:post, attributes)
end