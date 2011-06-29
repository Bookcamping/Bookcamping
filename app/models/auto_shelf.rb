class AutoShelf
  LIMIT = 20
  NAMES = ['ultimas', 'comentadas', 'valoradas', 'deseadas']

  def self.find(name, camp)
    if NAMES.include? name
      AutoShelf.new(name, camp)
    else
      AutoShelf.new('none', nil)
    end
  end

  def initialize(name, camp)
    @name = name
    @camp = camp
  end

  def name
    @name
  end

  def title
    I18n.t("autoshelf.name.#{@name}")
  end

  def books
    case @name
      when 'ultimas'
        @camp.books.order('id DESC').limit(LIMIT)
      when 'comentadas'
        @camp.books.where('comments_count > 0').order('comments_count DESC').limit(LIMIT)
      when 'valoradas'
        @camp.books.where('like_it_marks > 0').order('like_it_marks DESC').limit(LIMIT)
      when 'deseadas'
        @camp.books.where('read_later_marks > 0').order('read_later_marks DESC').limit(LIMIT)
      else
        []
    end
  end

end