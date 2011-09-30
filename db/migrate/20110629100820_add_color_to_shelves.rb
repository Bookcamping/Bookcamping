class AddColorToShelves < ActiveRecord::Migration
  def change
    add_column :camp_shelves, :color, :string, :limit => 16


    index = 0

    Shelf.all.each do |shelf|
      color = Shelf::COLORS[index]
      shelf.update_attribute(:color, color)
      index += 1
      index = 0 if index == Shelf::COLORS.length
    end
  end
end
