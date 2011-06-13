class AutoShelf
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :name, :books, :books_count, :user, :created_at

  LIMIT = 20
  NAMES = [:ultimas, :comentadas, :valoradas, :deseadas]

  def self.find(name, current_camp)
    NAMES.include?(name.to_sym) ? AutoShelf.new(name.to_sym, current_camp) : nil
  end

  def initialize(id, current_camp)
    @id = id
    @user = User.find 1
    @name = I18n.t("app.lists.#{id}").html_safe
    @books = case id.to_sym
               when :ultimas
                 current_camp.books.order('id DESC').limit(LIMIT)
               when :comentadas
                 current_camp.books.where('comments_count > 0').order('comments_count DESC').limit(LIMIT)
               when :valoradas
                 current_camp.books.where('like_it_marks > 0').order('like_it_marks DESC').limit(LIMIT)
               when :deseadas
                 current_camp.books.where('read_later_marks > 0').order('read_later_marks DESC').limit(LIMIT)
             end
    @books_count = @books ? @books.count : 0
    @created_at = Time.now
  end

  def to_model
    self
  end

  def persisted?
    false
  end

end
