class CleanVersions < ActiveRecord::Migration
  def up
    change_column :versions, :item_type, :string, limit: 40
    add_column :versions, :extra, :string, limit: 40
    remove_column :versions, :processed

    Version.where(item_type: 'Shelf') do |v|
      shelf = Shelf.find_by_id v.item_id
      if shelf
        v.extra = shelf.type
        v.save
      end 
    end
  end

  def down
    remove_column :versions, :extra
    add_column :versions, :processed, :boolean, default: false
  end
end
