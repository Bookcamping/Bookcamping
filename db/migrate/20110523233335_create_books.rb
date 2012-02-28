class CreateBooks < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.belongs_to :user
      t.belongs_to :reference_list
      t.string :title, :limit => 300
      t.string :authors, :limit => 100
      t.string :editor, :limit => 100
      t.string :description, :limit => 512
      t.string :url, :limit => 300
      t.timestamps
    end

    add_index :references, :reference_list_id
    add_index :references, :user_id
  end
end
