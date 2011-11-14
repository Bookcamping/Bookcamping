# User
#
#create_table "users", :force => true do |t|
#  t.string   "name" REQUIRED
#  t.string   "provider"
#  t.string   "uid"
#  t.string   "email"
#  t.string   "rol",           :limit => 10
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.integer  "login_count",                 :default => 0
#  t.datetime "last_login_at"
#end
class User < ActiveRecord::Base
  has_many :book_lists
  has_many :books
  has_many :memberships
  has_many :user_shelves, dependent: :destroy
  has_many :profile_shelves, dependent: :destroy
  has_one :profile_shelf, conditions: {rol: 'my_references'}


  validates :name, presence: true

  def add_book(book)
    book.user = self
    User.transaction do
      book.save
      self.profile_shelf.add_book(book, self)
      return true
    end
    return false
  end


  def personal_shelves_for(camp)
    profile_shelves.by_camp(camp) + user_shelves.by_camp(camp)
  end

  def public_shelves_for(camp)
    profile_shelves.by_camp(camp).public + user_shelves.by_camp(camp).public
  end

  def super?
    self.rol == 'super'
  end

  def admin?
    self.rol == 'admin' || self.rol == 'super'
  end


  def to_param
    "#{id}-#{name.parameterize}"
  end


end
