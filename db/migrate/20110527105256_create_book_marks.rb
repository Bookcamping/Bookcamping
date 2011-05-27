class CreateBookMarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.belongs_to :book
      t.belongs_to :user
      t.belongs_to :camp
      t.string :name

      t.timestamps
    end

    add_column :books, :marks, :string, :limit => 300

    add_index :bookmarks, :book_id
    add_index :bookmarks, :user_id
    add_index :bookmarks, :camp_id
  end
end
