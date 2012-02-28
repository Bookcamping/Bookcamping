class ExpandBookBody < ActiveRecord::Migration
  def up
    change_column :references, :description, :text
  end

  def down
    change_column :references, :description, :string, :limit => 512
  end
end
