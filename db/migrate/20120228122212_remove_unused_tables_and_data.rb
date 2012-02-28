class RemoveUnusedTablesAndData < ActiveRecord::Migration
  def change
    drop_table :bookmarks
    drop_table :mercury_images
    drop_table :notices

    Version.destroy_all(whodunnit: nil)
  end

end
