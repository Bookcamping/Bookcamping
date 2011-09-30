class AddDescriptionAndTypeToShelves < ActiveRecord::Migration
  def change
    remove_column :camp_shelves, :description
    add_column :camp_shelves, :description, :text
    add_column :camp_shelves, :rol, :string, :limit => 32
  end
end
