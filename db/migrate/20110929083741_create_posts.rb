class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :camp
      t.belongs_to :user
      t.string :author, :limit => 100
      t.string :title, :limit => 300
      t.text :body
      t.string :visibility, :limit => 16
      t.datetime :published_at
      t.timestamps
    end
  end
end
