class AddFieldsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :glasslevel, :string, :limit => 50
    add_column :books, :license, :string, :limit => 50
  end
end
