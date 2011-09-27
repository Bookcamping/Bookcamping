Given /^a book titled "([^"]*)"$/ do |title|
  Given "a camp"
  book = FactoryGirl.create(:book, title: title, camp: @camp)
end

When /^a book titled "([^"]*)" inside section "([^"]*)"$/ do |title, section|
  Given "a camp"
  section = @camp.shelves.find_by_name section
  puts "Creating book #{title}"
  book = FactoryGirl.create(:book, title: title, camp: @camp)
  puts "Book #{book.inspect}"
  section.add_book book, book.user
end