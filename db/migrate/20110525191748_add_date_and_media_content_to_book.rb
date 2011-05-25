class AddDateAndMediaContentToBook < ActiveRecord::Migration
  def change
    add_column :books, :media, :string, :limit => 1024
    add_column :books, :media_type, :string, :limit => 32
    add_column :books, :date, :string, :limit => 40
  end
end
