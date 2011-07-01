class AddDescriptionAndTypeToShelves < ActiveRecord::Migration
  def change
    remove_column :shelves, :description
    add_column :shelves, :description, :text
    add_column :shelves, :rol, :string, :limit => 32
  end
end
