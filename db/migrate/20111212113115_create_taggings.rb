class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :user
      t.belongs_to :reference
      t.belongs_to :tag

      t.timestamps
    end

    add_index :taggings, [:reference_id, :tag_id], unique: true
  end
end
