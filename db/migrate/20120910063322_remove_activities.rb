class RemoveActivities < ActiveRecord::Migration
  def up
    drop_table :activities
  end

  def down
    create_table "activities", :force => true do |t|
      t.integer  "user_id"
      t.string   "user_name"
      t.string   "user_url"
      t.integer  "resource_id"
      t.string   "resource_type"
      t.string   "action",        :limit => 16
      t.string   "title",         :limit => 200
      t.string   "url",           :limit => 200
      t.datetime "activity_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "version_id"
    end
  end
end
