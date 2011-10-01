class CampShelf < Shelf

  def visible_public?
    self.visibility == 'public'
  end
end

