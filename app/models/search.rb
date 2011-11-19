class Search
  def initialize(search_type, collection, term)
    @search_type = search_type
    @collection = collection
    @term = term
  end

  def term
    @term
  end

  def results
    if term.length > 2
      match = "%#{term}%"
      if @search_type == :books
        @collection.where('title LIKE ? OR authors LIKE ? OR editor LIKE ?', match, match, match)
      elsif @search_type == :users
        @collection.where('name LIKE ?', match)
      else
        @collection.where(id: -1)
      end
    else
      @collection.where(id: -1)
    end
  end
end

