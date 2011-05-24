class CreateBookList < ActiveRecord::Migration
  def change
    create_table :book_lists do |t|
      t.belongs_to :user
      t.string :name
      t.integer :position
      t.timestamps
    end

    add_index :book_lists, :user_id
  end
end
