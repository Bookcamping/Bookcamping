# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111211230325) do

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
  end

  create_table "book_lists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_lists", ["user_id"], :name => "index_book_lists_on_user_id"

  create_table "bookmarks", :force => true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.integer  "camp_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["book_id"], :name => "index_bookmarks_on_book_id"
  add_index "bookmarks", ["camp_id"], :name => "index_bookmarks_on_camp_id"
  add_index "bookmarks", ["user_id"], :name => "index_bookmarks_on_user_id"

  create_table "books", :force => true do |t|
    t.integer  "user_id"
    t.integer  "book_list_id"
    t.string   "title",            :limit => 300
    t.string   "authors",          :limit => 100
    t.string   "editor",           :limit => 100
    t.text     "description"
    t.string   "url",              :limit => 300
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                   :default => 0
    t.string   "glasslevel",       :limit => 50
    t.string   "license",          :limit => 50
    t.string   "media",            :limit => 1024
    t.string   "media_type",       :limit => 32
    t.string   "date",             :limit => 40
    t.integer  "camp_id"
    t.string   "marks",            :limit => 300
    t.integer  "like_it_marks",                    :default => 0
    t.integer  "read_later_marks",                 :default => 0
    t.integer  "license_id"
  end

  add_index "books", ["book_list_id"], :name => "index_books_on_book_list_id"
  add_index "books", ["camp_id"], :name => "index_books_on_camp_id"
  add_index "books", ["user_id"], :name => "index_books_on_user_id"

  create_table "camps", :force => true do |t|
    t.string   "name",                :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "model_name",          :limit => 32
    t.boolean  "show_media_on_lists",                :default => false
  end

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "ancestry"
    t.string   "body",          :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "camp_id"
  end

  add_index "comments", ["camp_id"], :name => "index_comments_on_camp_id"
  add_index "comments", ["resource_id", "resource_type"], :name => "index_comments_on_resource_id_and_resource_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "identities", :force => true do |t|
    t.string   "uid"
    t.integer  "user_id"
    t.string   "provider"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "licenses", :force => true do |t|
    t.string   "name",       :limit => 300
    t.string   "url",        :limit => 500
    t.string   "icon",       :limit => 300
    t.boolean  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_bites", :force => true do |t|
    t.integer  "camp_id"
    t.integer  "user_id"
    t.string   "title",        :limit => 100
    t.string   "caption",      :limit => 300
    t.string   "link",         :limit => 300
    t.string   "content_type", :limit => 32
    t.string   "file_content", :limit => 300
    t.string   "render_as",    :limit => 32
    t.string   "position",     :limit => 16
    t.integer  "width"
    t.integer  "height"
    t.string   "url_content",  :limit => 300
    t.text     "text_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notices", :force => true do |t|
    t.string   "body",         :limit => 500
    t.string   "level",        :limit => 32
    t.date     "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "author",         :limit => 100
    t.string   "title",          :limit => 200
    t.text     "body"
    t.string   "visibility",     :limit => 16
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                :default => 0
    t.string   "content_type",   :limit => 32
    t.string   "slug",           :limit => 200
  end

  create_table "shelf_items", :force => true do |t|
    t.integer  "shelf_id"
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.integer  "camp_id"
    t.string   "mark",       :limit => 32
  end

  add_index "shelf_items", ["book_id"], :name => "index_shelf_items_on_book_id"
  add_index "shelf_items", ["camp_id"], :name => "index_shelf_items_on_camp_id"
  add_index "shelf_items", ["shelf_id"], :name => "index_shelf_items_on_shelf_id"
  add_index "shelf_items", ["user_id"], :name => "index_shelf_items_on_user_id"

  create_table "shelves", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",           :limit => 200
    t.string   "slug",           :limit => 50
    t.integer  "books_count",                   :default => 0
    t.integer  "comments_count",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "camp_id"
    t.string   "color",          :limit => 16
    t.text     "description"
    t.string   "rol",            :limit => 32
    t.string   "type",           :limit => 32
    t.string   "visibility",     :limit => 16
  end

  add_index "shelves", ["camp_id"], :name => "index_shelves_on_camp_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name", :limit => 100
    t.string "slug", :limit => 100
  end

  add_index "tags", ["slug"], :name => "index_tags_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name",            :limit => 100
    t.string   "email"
    t.string   "rol",             :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "login_count",                    :default => 0
    t.datetime "last_login_at"
    t.string   "twitter",         :limit => 150
    t.boolean  "email_visible",                  :default => false
    t.boolean  "twitter_visible",                :default => false
    t.boolean  "email_confirmed",                :default => false
    t.string   "description",     :limit => 300
    t.boolean  "active",                         :default => false
    t.string   "slug",            :limit => 100
  end

  add_index "users", ["slug"], :name => "index_users_on_slug"

  create_table "versions", :force => true do |t|
    t.string   "item_type",                                    :null => false
    t.integer  "item_id",                                      :null => false
    t.string   "event",                                        :null => false
    t.string   "whodunnit"
    t.string   "title",      :limit => 300
    t.string   "user_name",  :limit => 100
    t.text     "object"
    t.datetime "created_at"
    t.integer  "camp_id"
    t.boolean  "processed",                 :default => false
  end

  add_index "versions", ["camp_id"], :name => "index_versions_on_camp_id"
  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
