class Library
  attr_reader :camp, :user

  def initialize(camp, user = nil)
    @camp = camp
    @user = user
    @sections = {}
    root = section(camp.name[1..-1])
    add(root, 'latest', 'list')
    add(root, 'commented', 'list')
    add(root, 'like_it', 'list')
    add(root, 'read_later', 'list')

    shelves = section('shelves')

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