class RemovePages < ActiveRecord::Migration
  def up
    drop_table :pages
    drop_table :categories
  end

  def down
    create_table "pages", :force => true do |t|
      t.string   "title"
      t.string   "slug"
      t.string   "author"
      t.string   "content_type",      :limit => 50
      t.text     "body"
      t.integer  "comments_count"
      t.integer  "user_id"
      t.datetime "created_at",                                     :null => false
      t.datetime "updated_at",                                     :null => false
      t.integer  "category_id"
      t.integer  "memberships_count",               :default => 0
    end
    create_table "categories", :force => true do |t|
      t.string   "name",        :limit => 64
      t.string   "slug",        :limit => 64
      t.string   "description", :limit => 300
      t.string   "section",     :limit => 32
      t.string   "view_level",  :limit => 16
      t.string   "edit_level",  :limit => 16
      t.datetime "created_at",                 :null => false
      t.datetime "updated_at",                 :null => false
    end
    add_index "categories", ["slug"], :name => "index_categories_on_slug"

  end
end
