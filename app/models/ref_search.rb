class RefSearch
  def initialize(collection)
    @collection = collection
  end

  def search(term)
    if term.length > 2
      @collection.where('title LIKE ? OR authors LIKE ? OR editor LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%")
    else
      @collection.where(id: -1)
    end
  end
end

