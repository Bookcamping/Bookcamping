class AddCoverImageToReferences < ActiveRecord::Migration
  def change
    add_column :references, :cover_image, :string, limit: 300
  end
end
