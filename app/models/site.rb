class Site
  def name
    '#bookcamping'
  end

  def camp_shelves(orderer = nil)
    orderer ? orderer.order_by(CampShelf.scoped) : CampShelf.scoped
  end

  def books
    Book.scoped
  end

  def explore_user_shelves
    UserShelf.where('books_count > 0').order(:updated_at).public.limit(10)
  end

  def explore_users
    User.order('updated_at DESC').limit(20)
  end

  def self.host
    Rails.env.production? ? 'http://bookcamping.cc' : 'localhost:3000'
  end

  def self.tables
    @tables ||= ActiveRecord::Base.connection.tables
  end
end

