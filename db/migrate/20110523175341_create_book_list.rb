class CreateBookList < ActiveRecord::Migration
  def change
    create_table :reference_lists do |t|
      t.belongs_to :user
      t.string :name
      t.integer :position
      t.timestamps
    end

    add_index :reference_lists, :user_id
  end
end
