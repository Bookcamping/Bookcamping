class CreateAutoShelves < ActiveRecord::Migration
  def change
    create_table :auto_shelves do |t|

      t.timestamps
    end
  end
end
