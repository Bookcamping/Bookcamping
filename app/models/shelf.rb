# Shelf
#
# SCHEMA
#create_table "shelves", :force => true do |t|
#  t.integer  "camp_id" # REQUIRED
#  t.integer  "user_id" # REQUIRED
#  t.string   "name",           :limit => 200 # REQUIRED
#  t.string   "slug",           :limit => 50
#  t.integer  "books_count",                   :default => 0
#  t.integer  "comments_count",                :default => 0
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.string   "color",          :limit => 16
#  t.text     "description"
#  t.string   "rol",            :limit => 32
#end
#
class Shelf < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :shelf_items, :dependent => :destroy
  has_many :books, :through => :shelf_items

  has_paper_trail :meta => {
      :title => Proc.new { |shelf| shelf.name },
      :camp_id => Proc.new { |shelf| shelf.camp_id },
      :user_name => Proc.new { |shelf| shelf.user.name }
  }


  validates :camp_id, :presence => true
  validates :user_id, :presence => true
  validates :name, presence: true, uniqueness: true

  COLORS = ['#db533d', '#86475e', '#afa9ad', '#e9c54b', '#64a353',
            '#c36d3b', '#ee8587', '#357391', '#67c095', '#4eaea8', '#f15a5b',
            '#44adc6', '#9a7fba', '#e7de21', '#c1a574', '#d4d1c2', '#2f723e',
            '#a0a96a', '#f68b1f', '#a5932b', '#c14f52', '#738f57', '#e18256',
            '#dbb727', '#008eb0', '#967448', '#c2c76c']


  def add_book(book, user)
    ShelfItem.create!(:shelf_id => self.id, :book_id => book.id, :user_id => user.id)
  end

  def background
    color? ? color : 'black'
  end

  def to_param
    limited = name.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end

end
