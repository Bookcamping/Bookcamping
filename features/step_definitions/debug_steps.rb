Then /^debug page$/ do
  puts "***************************************************************"
  puts page.body.gsub("\n", "\n            ")
  puts "***************************************************************"
end

Given /^debug sql on$/ do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

Then /^debug a shelf named "([^"]*)"$/ do |name|
  shelf = Shelf.find_by_name name
  puts "SHELF #{name}"
  puts shelf.inspect
  puts "BOOKS #{shelf.books.count}"
  shelf.books.each {|b| puts b.inspect}
end

Then /^debug shelf items$/ do
  puts "SECTION ITEMS (#{ShelfItem.count})"
  ShelfItem.all.each do |item|
    puts item.inspect
  end
end

Then /^debug shelves$/ do
  puts "SHELVES (#{Shelf.count})"
  Shelf.all.each do |shelf|
    puts shelf.inspect
  end
end


Then /^debug camp shelves$/ do
  puts "CAMP SHELVES (#{CampShelf.count})"
  CampShelf.all.each do |shelf|
    puts shelf.inspect
  end
end

Then /^debug books$/ do
  puts "BOOKS (#{Book.count})"
  Book.all.each do |book|
    puts book.inspect
  end
end
When /^debug posts$/ do
  puts "POSTS (#{Post.count})"
  Post.all.each do |post|
    puts post.inspect
  end
end

Given /^debug media bites$/ do
  puts "MEDIA BITES (#{MediaBite.count})"
  MediaBite.all.each do |media|
    puts media.inspect
  end
end