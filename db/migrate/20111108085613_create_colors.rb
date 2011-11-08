class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :name
      t.string :value

      t.timestamps
    end

    ['#db533d', '#86475e', '#afa9ad', '#e9c54b', '#64a353',
     '#c36d3b', '#ee8587', '#357391', '#67c095', '#4eaea8', '#f15a5b',
     '#44adc6', '#9a7fba', '#e7de21', '#c1a574', '#d4d1c2', '#2f723e',
     '#a0a96a', '#f68b1f', '#a5932b', '#c14f52', '#738f57', '#e18256',
     '#dbb727', '#008eb0', '#967448', '#c2c76c'].each do |value|
      Color.create!(name: value, value: value)
    end
  end
end
