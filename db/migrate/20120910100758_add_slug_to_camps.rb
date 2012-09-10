class AddSlugToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :slug, :string, limit: 100
    remove_column :camps, :open
    remove_column :camps, :closed
    remove_column :camps, :model_name
    add_index :camps, :slug
  end
end
