Given /^a reference titled "([^"]*)"$/ do |title|
  Given "a camp"
  Given "a shelf"
  @reference = FactoryGirl.create(:reference, title: title, camp: @camp,
                            include_in_shelf_id: @shelf.id)
end

When /^a reference titled "([^"]*)" inside shelf "([^"]*)"$/ do |title, section|
  Given "a camp"
  shelf = @camp.shelves.find_by_name!(section)
  @reference = FactoryGirl.create(:reference, title: title, camp: @camp,
                     include_in_shelf_id: shelf.id)
end
When /^the reference titled "([^"]*)" inside shelf "([^"]*)"$/ do |title, name|
  Given "a camp"
  shelf = @camp.shelves.find_by_name!(name)
  @reference = @camp.references.find_by_title!(title)
  shelf.add_reference @reference, @reference.user
end

When /^last reference has "([^"]*)" as "([^"]*)"$/ do |value, name|
  @reference.update_attribute(name, value)
end