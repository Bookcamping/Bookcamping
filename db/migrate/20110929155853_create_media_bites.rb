class CreateMediaBites < ActiveRecord::Migration
  def change
    create_table :media_bites do |t|
      t.belongs_to :camp
      t.belongs_to :user
      t.string :title, limit: 100
      t.string :caption, limit: 300
      t.string :link, limit: 300
      t.string :content_type, limit: 32
      t.string :file_content, limit: 300
      t.string :render_as, limit: 32
      t.string :position, limit: 16
      t.integer :width
      t.integer :height
      t.string :url_content, limit: 300
      t.text :text_content
      t.timestamps
    end
  end
end
