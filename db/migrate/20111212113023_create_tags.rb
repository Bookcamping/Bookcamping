class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, limit: 100
      t.string :slug, limit: 100
      t.integer :size, default: 0
      t.timestamps
    end
    add_index :tags, :slug, unique: true
  end
end
