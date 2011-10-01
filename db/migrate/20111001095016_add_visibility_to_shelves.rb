class AddVisibilityToShelves < ActiveRecord::Migration
  def change
    add_column :shelves, :visibility, :string, :limit => 16

    Shelf.all.each do |shelf|
      shelf.update_attribute(:visibility, 'public')
    end
  end
end
