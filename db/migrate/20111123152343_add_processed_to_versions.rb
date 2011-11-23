class AddProcessedToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :processed, :boolean, default: false

    Version.update_all processed: true
  end
end
