class CreateShelves < ActiveRecord::Migration
  def change
    create_table :camp_shelves do |t|
      t.belongs_to :user
      t.string :name, :limit => 200
      t.string :slug, :limit => 50
      t.string :description, :limit => 512
      t.integer :books_count, :default => 0
      t.integer :comments_count, :default => 0
      t.timestamps
    end
  end
end
