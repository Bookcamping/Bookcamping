class AddColorToShelves < ActiveRecord::Migration
  def change
    add_column :shelves, :color, :string, :limit => 16

    colors = ['db533d', '86475e', 'afa9ad', 'e9c54b', '64a353',
              'c36d3b', 'ee8587', '357391', '67c095', '4eaea8', 'f15a5b',
              '44adc6', '9a7fba', '264c51']

    index = 0

    Shelf.all.each do |shelf|
      color = colors[index]
      shelf.update_attribute(:color, "##{color}")
      index += 1
      index = 0 if index == colors.length
    end
  end
end
