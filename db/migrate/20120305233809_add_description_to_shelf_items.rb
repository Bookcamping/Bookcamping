class AddDescriptionToShelfItems < ActiveRecord::Migration
  def change
    add_column :shelf_items, :description, :text
  end
end
