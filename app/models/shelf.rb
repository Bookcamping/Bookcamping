# Shelf
#
# Una lista en bookcamping. Puede ser de varios tipos:
# CampShelf: una estantería. cada Camp(ing) tiene sus estanterías
# ProfileShelf: listas personales especiales (no se pueden borrar)
# UserShelf: listas personales
# CuratedShelf: listas comisariadas (habría que pensar sobre ello)
#
#  t.integer  "user_id"
#  t.string   "name",           :limit => 200
#  t.string   "slug",           :limit => 50
#  t.integer  "books_count",                   :default => 0
#  t.integer  "comments_count",                :default => 0
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.integer  "camp_id"
#  t.string   "color",          :limit => 16
#  t.text     "description"
#  t.string   "rol",            :limit => 32
#  t.string   "type",           :limit => 32
#  t.string   "visibility",     :limit => 16
#
#
#
class Shelf < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user
  has_many :shelf_items, dependent: :destroy
  has_many :books, through: :shelf_items

  has_paper_trail :meta => {
      :title => Proc.new { |shelf| shelf.name },
      :camp_id => Proc.new { |shelf| shelf.camp_id },
      :user_name => Proc.new { |shelf| shelf.user.name }
  }

  scope :public, where(visibility: :public)
  scope :private, where(visibility: :private)

  validates :user_id, presence: true
  validates :name, presence: true
  validates :visibility, presence: true


  COLORS = ['#db533d', '#86475e', '#afa9ad', '#e9c54b', '#64a353',
            '#c36d3b', '#ee8587', '#357391', '#67c095', '#4eaea8', '#f15a5b',
            '#44adc6', '#9a7fba', '#e7de21', '#c1a574', '#d4d1c2', '#2f723e',
            '#a0a96a', '#f68b1f', '#a5932b', '#c14f52', '#738f57', '#e18256',
            '#dbb727', '#008eb0', '#967448', '#c2c76c']

  ROLES = []
  VISIBILITIES = [:private, :public]


  def background
    color? ? color : '#db533d'
  end

  def to_param
    limited = name.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end

  def visible_public?
    false
  end

end
