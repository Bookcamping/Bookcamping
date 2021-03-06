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

ActiveRecord::Schema.define(:version => 20120910100758) do

  create_table "camps", :force => true do |t|
    t.string   "name",                :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_media_on_lists",                :default => false
    t.string   "lang",                :limit => 8
    t.text     "settings"
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "host",                :limit => 100
    t.integer  "memberships_count",                  :default => 0
    t.string   "slug",                :limit => 100
  end

  add_index "camps", ["host"], :name => "index_camps_on_host"
  add_index "camps", ["slug"], :name => "index_camps_on_slug"

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
    t.string   "name",             :limit => 300
    t.string   "url",              :limit => 500
    t.string   "icon",             :limit => 300
    t.boolean  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "references_count"
    t.string   "image_url",        :limit => 200
    t.string   "slug",             :limit => 300
    t.text     "body"
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

  create_table "memberships", :force => true do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "memberships", ["resource_type", "resource_id"], :name => "index_memberships_on_resource_type_and_resource_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

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

  create_table "publishers", :force => true do |t|
    t.string   "name",             :limit => 300
    t.string   "slug",             :limit => 100
    t.string   "header_url",       :limit => 300
    t.string   "homepage_url",     :limit => 300
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "archive_slug",     :limit => 100
    t.integer  "references_count",                :default => 0
  end

  add_index "publishers", ["slug"], :name => "index_publishers_on_slug", :unique => true

  create_table "references", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",          :limit => 300
    t.string   "authors",        :limit => 100
    t.string   "editor",         :limit => 100
    t.text     "description"
    t.string   "url",            :limit => 300
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                 :default => 0
    t.string   "media",          :limit => 1024
    t.string   "media_type",     :limit => 32
    t.string   "date",           :limit => 40
    t.integer  "camp_id"
    t.string   "marks",          :limit => 300
    t.integer  "license_id"
    t.integer  "publisher_id"
    t.string   "ref_type",       :limit => 16
    t.string   "archive_slug",   :limit => 100
    t.integer  "group_id"
    t.boolean  "open",                           :default => true
    t.string   "cover_image",    :limit => 300
  end

  add_index "references", ["camp_id"], :name => "index_books_on_camp_id"
  add_index "references", ["user_id"], :name => "index_books_on_user_id"

  create_table "shelf_items", :force => true do |t|
    t.integer  "shelf_id"
    t.integer  "reference_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.integer  "camp_id"
    t.string   "mark",         :limit => 32
    t.text     "description"
  end

  add_index "shelf_items", ["camp_id"], :name => "index_shelf_items_on_camp_id"
  add_index "shelf_items", ["reference_id"], :name => "index_shelf_items_on_book_id"
  add_index "shelf_items", ["shelf_id"], :name => "index_shelf_items_on_shelf_id"
  add_index "shelf_items", ["user_id"], :name => "index_shelf_items_on_user_id"

  create_table "shelf_members", :force => true do |t|
    t.integer  "shelf_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shelves", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",                :limit => 200
    t.string   "slug",                :limit => 50
    t.integer  "references_count",                   :default => 0
    t.integer  "comments_count",                     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "camp_id"
    t.string   "color",               :limit => 16
    t.text     "description"
    t.string   "type",                :limit => 32
    t.integer  "shelf_members_count",                :default => 0
    t.boolean  "open",                               :default => false
    t.integer  "group_id"
    t.string   "settings",            :limit => 300
    t.boolean  "hidden",                             :default => false
    t.integer  "memberships_count",                  :default => 0
  end

  add_index "shelves", ["camp_id"], :name => "index_shelves_on_camp_id"
  add_index "shelves", ["group_id"], :name => "index_shelves_on_group_id"
  add_index "shelves", ["slug"], :name => "index_shelves_on_slug"
  add_index "shelves", ["user_id"], :name => "index_shelves_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reference_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["reference_id", "tag_id"], :name => "index_taggings_on_reference_id_and_tag_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "name",       :limit => 100
    t.string   "slug",       :limit => 100
    t.integer  "size",                      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["slug"], :name => "index_tags_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name",              :limit => 100
    t.string   "email"
    t.string   "rol",               :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "login_count",                      :default => 0
    t.datetime "last_login_at"
    t.string   "twitter",           :limit => 150
    t.string   "description",       :limit => 300
    t.string   "slug",              :limit => 100
    t.string   "settings",          :limit => 300
    t.string   "password_digest"
    t.string   "uid_twitter"
    t.string   "uid_facebook"
    t.string   "uid_google"
    t.string   "recovery_code"
    t.boolean  "group",                            :default => false
    t.integer  "memberships_count",                :default => 0
    t.string   "avatar",            :limit => 300
  end

  add_index "users", ["slug"], :name => "index_users_on_slug"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :limit => 40,  :null => false
    t.integer  "item_id",                   :null => false
    t.string   "event",                     :null => false
    t.string   "whodunnit"
    t.string   "title",      :limit => 300
    t.string   "user_name",  :limit => 100
    t.text     "object"
    t.datetime "created_at"
    t.integer  "camp_id"
    t.string   "extra",      :limit => 40
  end

  add_index "versions", ["camp_id"], :name => "index_versions_on_camp_id"
  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
