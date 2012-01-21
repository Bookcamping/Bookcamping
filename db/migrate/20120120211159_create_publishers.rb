class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name, limit: 300
      t.string :slug, limit: 100
      t.string :header_url, limit: 300
      t.string :homepage_url, limit: 300
      t.timestamps
    end
    add_index :publishers, :slug, unique: true
  end
end
