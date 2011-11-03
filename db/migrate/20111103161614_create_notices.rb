class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :body, limit: 500
      t.string :level, limit: 32
      t.date :published_at
      t.timestamps
    end
  end
end
