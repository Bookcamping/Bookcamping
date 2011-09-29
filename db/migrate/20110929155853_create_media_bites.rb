class CreateMediaBites < ActiveRecord::Migration
  def change
    create_table :media_bites do |t|
      t.belongs_to :camp
      t.belongs_to :user
      t.string :title, limit: 200
      t.string :file, limit: 300
      t.string :content_type, limit: 32
      t.string :url, limit: 300
      t.text :rendered
      t.timestamps
    end
  end
end
