class CreateShelfMembers < ActiveRecord::Migration
  def change
    create_table :shelf_members do |t|
      t.belongs_to :shelf
      t.belongs_to :user
      t.timestamps
    end

    add_column :shelves, :shelf_members_count, :integer, default: 0

    UserShelf.all.each do |shelf|
      ShelfMember.create!(shelf_id: shelf.id, user_id: shelf.user_id)
    end
  end
end
