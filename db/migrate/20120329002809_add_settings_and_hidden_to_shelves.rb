class AddSettingsAndHiddenToShelves < ActiveRecord::Migration
  def change
    remove_column :shelves, :rol
    remove_column :shelves, :visibility
    add_column :shelves, :settings, :string, limit: 300
    add_column :shelves, :hidden, :boolean, default: false
    add_index :shelves, :user_id
    add_index :shelves, :group_id
    add_index :shelves, :slug
  end
end
