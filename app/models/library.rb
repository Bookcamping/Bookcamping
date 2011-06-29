class Library
  attr_reader :camp, :user, :count

  def initialize(camp, user = nil)
    @camp = camp
    @user = user
    @sections = {}
    @count = camp.books.count
    root = section("#{camp.name} (#{@count})")
    add(root, 'ultimas', 'list')
    add(root, 'comentadas', 'list')
    add(root, 'valoradas', 'list')
    add(root, 'deseadas', 'list')

    shelves = section('listas')
    camp.shelves.each {|s| add(shelves, "#{s.name} (#{s.books_count})", 'shelf', s.id)}

  end

  def section(name)
    @sections[name] ||= []
    @sections[name]
  end

  def add(section, name, type, id = nil)
    section << {:name => name, :type => type, :id => id}
  end

  def section_names
    @sections.keys
  end

end