class CreateShelfItems < ActiveRecord::Migration
  def change
    create_table :shelf_items do |t|
      t.belongs_to :shelf
      t.belongs_to :reference
      t.belongs_to :user
      t.datetime :created_at
    end

    add_index :shelf_items, :shelf_id
    add_index :shelf_items, :reference_id
    add_index :shelf_items, :user_id

    BookList.all.each do |list|
      shelf = Shelf.create(:user_id => list.user_id, :name  => list.name)
      list.references.each do |reference|
        ShelfItem.create(:shelf_id => shelf.id, :reference_id => reference.id, :user_id => reference.user_id)
      end
    end

  end

end
