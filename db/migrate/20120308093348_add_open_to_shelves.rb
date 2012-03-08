class AddOpenToShelves < ActiveRecord::Migration
  def change
    add_column :shelves, :open, :boolean, default: false
  end
end
