# User
#
# 
class User < ActiveRecord::Base
  include Users::Create
  include Users::Identities
  has_many :identities, dependent: :destroy
  has_many :books, dependent: :restrict
  has_many :comments, dependent: :destroy
  has_many :versions, foreign_key: :whodunnit

  # Shelves
  has_many :shelves, dependent: :restrict
  has_many :camp_shelves
  has_many :user_shelves, dependent: :destroy

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

  def self.by_param(param)
    User.find_by_slug(param) || User.find(param)
  end


  protected
  def update_slug
    self.slug = self.name.parameterize
  end

end
