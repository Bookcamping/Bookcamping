class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user
      t.string :user_name
      t.string :user_url
      t.belongs_to :resource, polymorphic: true
      t.string :action, limit: 16
      t.string :title, limit: 200
      t.string :url, limit: 200
      t.datetime :activity_at
      t.timestamps
    end
  end
end
