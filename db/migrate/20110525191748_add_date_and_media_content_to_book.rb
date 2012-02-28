class AddDateAndMediaContentToBook < ActiveRecord::Migration
  def change
    add_column :references, :media, :string, :limit => 1024
    add_column :references, :media_type, :string, :limit => 32
    add_column :references, :date, :string, :limit => 40
  end
end
