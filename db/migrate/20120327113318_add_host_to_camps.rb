class AddHostToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :host, :string, limit: 100
    add_index :camps, :host
  end
end
