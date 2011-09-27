Then /^debug page$/ do
  puts "***************************************************************"
  puts page.body.gsub("\n", "\n            ")
  puts "***************************************************************"
end

Given /^debug sql on$/ do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

Then /^debug a section named "([^"]*)"$/ do |name|
  @section = Shelf.find_by_name name
  puts "SECTION #{name}"
  puts @section.inspect
  puts "BOOKS #{@section.books.count}"
  @section.books.each {|b| puts b.inspect}
end

Then /^debug section items$/ do
  puts "SECTION ITEMS (#{ShelfItem.count})"
  ShelfItem.all.each do |item|
    puts item.inspect
  end
end

Then /^debug sections$/ do
  puts "SECTIONS (#{Shelf.count})"
  Shelf.all.each do |section|
    puts section.inspect
  end
end

Then /^debug books$/ do
  puts "BOOKS (#{Book.count})"
  Book.all.each do |book|
    puts book.inspect
  end
end