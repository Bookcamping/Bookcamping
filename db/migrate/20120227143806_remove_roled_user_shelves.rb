class RemoveRoledUserShelves < ActiveRecord::Migration
  def up
    UserShelf.where(rol: 'like_it').destroy_all
    UserShelf.where(rol: 'read_later').destroy_all
    UserShelf.where(rol: 'my_references').destroy_all
  end

  def down
  end
end
