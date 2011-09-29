Given /^a book titled "([^"]*)"$/ do |title|
  Given "a camp"
  Given "a section"
  book = FactoryGirl.create(:book, title: title, camp: @camp,
                            include_in_shelf_id: @section.id)
  if book.valid?
    puts "Book CREATED #{book.inspect}"
  else
    puts "Book not valid!"
    puts book.inspect
    puts book.errors.inpsect
  end
end

When /^a book titled "([^"]*)" inside section "([^"]*)"$/ do |title, section|
  Given "a camp"
  section = @camp.shelves.find_by_name section
  FactoryGirl.create(:book, title: title, camp: @camp,
                     include_in_shelf_id: section.id)
end