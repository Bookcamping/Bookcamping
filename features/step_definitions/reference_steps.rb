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