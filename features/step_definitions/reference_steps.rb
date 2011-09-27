Given /^a book titled "([^"]*)"$/ do |title|
  Given "a camp"
  book = FactoryGirl.create(:book, title: title, camp: @camp)
end

When /^a book titled "([^"]*)" inside section "([^"]*)"$/ do |title, section|
  Given "a camp"
  section = @camp.shelves.find_by_name section
  FactoryGirl.create(:book, title: title, camp: @camp,
                            include_in_shelf_id: section.id)
end