Given /^a book titled "([^"]*)"$/ do |title|
  @book = FactoryGirl.create(:book, title: title)
end