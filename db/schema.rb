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

ActiveRecord::Schema.define(:version => 20110524123719) do

  create_table "book_lists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_lists", ["user_id"], :name => "index_book_lists_on_user_id"

  create_table "books", :force => true do |t|
    t.integer  "user_id"
    t.integer  "book_list_id"
    t.string   "title",          :limit => 300
    t.string   "authors",        :limit => 100
    t.string   "editor",         :limit => 100
    t.string   "description",    :limit => 512
    t.string   "url",            :limit => 300
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                :default => 0
  end

  add_index "books", ["book_list_id"], :name => "index_books_on_book_list_id"
  add_index "books", ["user_id"], :name => "index_books_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "ancestry"
    t.string   "body",          :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["resource_id", "resource_type"], :name => "index_comments_on_resource_id_and_resource_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "rol",        :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
