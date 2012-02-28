class AddFieldsToBooks < ActiveRecord::Migration
  def change
    add_column :references, :glasslevel, :string, :limit => 50
    add_column :references, :license, :string, :limit => 50
  end
end
