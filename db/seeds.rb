
silvink = User.create!(:name => 'Silvink')
dani = User.create!(:name => 'Dani')

def new_section(number, user)
  text = File.read(File.join('.', 'db/content', "#{number}.txt"))
  index = 0
  book = ''
  list = nil
  text.each_line do |line|
    if index == 0
      list = BookList.create!(:name => line, :position => index, :user => user)
      puts "SECTION**** #{line}"
      book = ''
    elsif line =~ /^\s*$/
      Book.create!(:book_list => list, :description => book, :user => user) unless book =~ /^\s*$/
      book = ''
    else
      book += line
    end
    index += 1
  end
end

0.upto(5).each { |n| new_section n, silvink }

