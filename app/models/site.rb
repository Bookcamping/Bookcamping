class Site
  def name
    '#bookcamping'
  end

  def books
    Book.scoped
  end

  def explore_user_shelves
    UserShelf.order(:updated_at).limit(10)
  end

  def explore_users
    User.where(active: true).order('updated_at DESC')
  end
end

