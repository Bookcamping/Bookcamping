class RenameBookToReference < ActiveRecord::Migration
  def change
    rename_table :books, :references
    rename_column :shelves, :books_count, :references_count
    rename_column :shelf_items, :book_id, :reference_id

    drop_table :book_lists
  end
end
