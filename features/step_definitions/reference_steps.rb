Given /^a book titled "([^"]*)"$/ do |title|
  Given "a camp"
  Given "a shelf"
  book = FactoryGirl.create(:book, title: title, camp: @camp,
                            include_in_shelf_id: @shelf.id)
end

When /^a book titled "([^"]*)" inside shelf "([^"]*)"$/ do |title, section|
  Given "a camp"
  shelf = @camp.shelves.find_by_name!(section)
  FactoryGirl.create(:book, title: title, camp: @camp,
                     include_in_shelf_id: shelf.id)
end
When /^the reference titled "([^"]*)" inside shelf "([^"]*)"$/ do |title, name|
  Given "a camp"
  shelf = @camp.shelves.find_by_name!(name)
  book = @camp.books.find_by_title!(title)
  shelf.add_book book, book.user
end