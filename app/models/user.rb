# User
#
#create_table "users", :force => true do |t|
#  t.string "name", :limit => 100
#  t.string "email"
#  t.string "rol", :limit => 10
#  t.datetime "created_at"
#  t.datetime "updated_at"
#  t.integer "login_count", :default => 0
#  t.datetime "last_login_at"
#  t.string "twitter", :limit => 150
#  t.boolean "email_visible", :default => false
#  t.boolean "twitter_visible", :default => false
#  t.boolean "email_confirmed", :default => false
#  t.string "description", :limit => 300
#  t.boolean  "active",                         :default => false
#  t.string   "slug",            :limit => 100
#end
class User < ActiveRecord::Base
  include Users::Create
  has_many :identities, dependent: :destroy
  has_many :books, dependent: :restrict
  has_many :comments, dependent: :destroy
  has_many :versions, foreign_key: :whodunnit

  # Shelves
  has_many :shelves, dependent: :restrict
  has_many :camp_shelves
  has_many :user_shelves, dependent: :destroy
  has_many :personal_shelves, class_name: 'Shelf', conditions: ["type = ? OR type = ?", 'UserShelf', 'ProfileShelf']

  # Profile shelves
  has_one :like_it_shelf, class_name: 'UserShelf', conditions: {rol: 'like_it'}
  has_one :read_later_shelf, class_name: 'UserShelf', conditions: {rol: 'read_later'}
  has_one :my_references_shelf, class_name: 'UserShelf', conditions: {rol: 'my_references'}

  # Scopes
  scope :admin, conditions: {rol: 'admin'}

  # Validations
  validates :name, presence: true, uniqueness: true
#  validates :email, presence: true, on: :create, unless: :twitter?
#  validates :email, uniqueness: true, if: :email?
# validates :password, presence: true, confirmation: true, on: :create
# validates :password_confirmation, presence: true, on: :create

  #has_secure_password

  # Callbacks
  before_save :update_slug
  after_create :create_profile_shelves

  attr_accessor :password, :password_confirmation


  def add_book(book)
    book.user = self
    User.transaction do
      book.save
      self.my_references_shelf.add_book(book)
      return true
    end
    return false
  end

  def super?
    self.rol == 'super'
  end

  def admin?
    self.rol == 'admin' || self.rol == 'super'
  end

  def to_param
    slug
  end


  def identify_with(password)
    id = identities.where(provider: 'bookcamping').first
    id = identities.build(provider: 'bookcamping', uid: email) unless id
    id.password = password
    id.save
    identities(true)
  end

  protected
  def update_slug
    self.slug = self.name.parameterize
  end

end
