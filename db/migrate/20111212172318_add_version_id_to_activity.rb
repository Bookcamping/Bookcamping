class AddVersionIdToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :version_id, :integer

  end
end
