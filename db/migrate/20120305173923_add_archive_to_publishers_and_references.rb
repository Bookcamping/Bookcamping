class AddArchiveToPublishersAndReferences < ActiveRecord::Migration
  def change
    add_column :references, :archive_slug, :string, limit: 100
    add_column :publishers, :archive_slug, :string, limit: 100
    add_column :publishers, :references_count, :integer, default: 0
  end
end
