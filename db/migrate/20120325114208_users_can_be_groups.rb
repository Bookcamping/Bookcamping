class UsersCanBeGroups < ActiveRecord::Migration
  def change
    add_column :users, :group, :boolean, default: false
    add_column :shelves, :group_id, :integer
    add_column :camps, :group_id, :integer
    add_column :camps, :open, :boolean, default: false
    add_column :camps, :closed, :boolean, default: false
    add_column :references, :group_id, :integer
    add_column :references, :open, :boolean, default: true
  end
end
