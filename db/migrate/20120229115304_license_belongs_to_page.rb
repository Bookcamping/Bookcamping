class LicenseBelongsToPage < ActiveRecord::Migration
  def change
    add_column :licenses, :page_id, :integer
    remove_column :licenses, :body
  end
end
