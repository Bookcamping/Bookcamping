# User
#
#create_table "users", :force => true do |t|
#  t.string   "provider"
#  t.string   "uid"
#  t.string   "name"
#  t.string   "email"
#  t.string   "rol",             :limit => 10
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.integer  "login_count",                    :default => 0
#  t.datetime "last_login_at"
#  t.string   "twitter",         :limit => 150
#  t.boolean  "email_visible",                  :default => false
#  t.boolean  "twitter_visible",                :default => false
#  t.boolean  "email_confirmed",                :default => false
#  t.string   "description",     :limit => 300
#  t.string   "password_digest"
#  t.string   "password_salt"
#  t.string   "twitter_uid"
#  t.string   "google_uid"
#  t.string   "facebook_uid"
#end
class User < ActiveRecord::Base
  has_many :books
  has_many :memberships, dependent: :destroy
  has_many :user_shelves, dependent: :destroy
  has_many :profile_shelves, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile_shelf, conditions: {rol: 'my_references'}

  scope :admin, conditions: {rol: 'admin'}

  validates :name, presence: true

  def add_book(book)
    book.user = self
    User.transaction do
      book.save
      self.profile_shelf.add_book(book)
      return true
    end
    return false
  end


  def personal_shelves
    profile_shelves + user_shelves
  end

  def public_shelves
    profile_shelves.public + user_shelves.public
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
