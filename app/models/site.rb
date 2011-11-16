class Site
  def name
    '#bookcamping'
  end
  def books
    Book.scoped
  end
end

