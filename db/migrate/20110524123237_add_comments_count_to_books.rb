class AddCommentsCountToBooks < ActiveRecord::Migration
  def change
    add_column :references, :comments_count, :integer, :default => 0
  end
end
