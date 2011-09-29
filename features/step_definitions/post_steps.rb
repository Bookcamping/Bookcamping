Given /^a blog post titled "([^"]*)"$/ do |title|
  Given "a camp"
  @post = FactoryGirl.create(:post, title: title, camp: @camp)
end

When /^last post is "([^"]*)"$/ do |visibility|
  @post.update_attribute(:visibility, visibility)
end