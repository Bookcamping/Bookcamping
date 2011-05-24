class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :resource, :polymorphic => true
      t.string :ancestry
      t.string :body, :limit => 512
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, [:resource_id, :resource_type]
  end
end
