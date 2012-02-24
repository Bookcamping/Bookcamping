class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.string :author
      t.string :content_type, limit: 50
      t.text :body
      t.string :view_level, limit: 20
      t.string :edit_level, limit: 20
      t.integer :comments_count
      t.belongs_to :user
      t.timestamps
    end
  end
end
