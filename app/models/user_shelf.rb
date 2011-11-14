class UserShelf < Shelf
  validates :name, uniqueness: {scope: [:user_id, :camp_id]}
end

