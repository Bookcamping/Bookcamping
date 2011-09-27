Given /^a book titled "([^"]*)"$/ do |title|
  @book = FactoryGirl.create(:book, title: title)
end

When /^a book titled "([^"]*)" inside section "([^"]*)"$/ do |title, section|
  @secion = Shelf.find_by_name section
  @section ||= FactoryGirl.create(:shelf, name: section)
  @book = Book.find_by_title title
  @book ||= FactoryGirl.create(:book, title: title)
  @section.add_book @book, @book.user
end