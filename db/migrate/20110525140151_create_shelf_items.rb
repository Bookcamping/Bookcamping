class CreateShelfItems < ActiveRecord::Migration
  def change
    create_table :shelf_items do |t|
      t.belongs_to :shelf
      t.belongs_to :book
      t.belongs_to :user
      t.datetime :created_at
    end

    add_index :shelf_items, :shelf_id
    add_index :shelf_items, :book_id
    add_index :shelf_items, :user_id

    BookList.all.each do |list|
      shelf = Shelf.create(:user_id => list.user_id, :name  => list.name)
      list.books.each do |book|
        ShelfItem.create(:shelf_id => shelf.id, :book_id => book.id, :user_id => book.user_id)
      end
    end

  end

end
