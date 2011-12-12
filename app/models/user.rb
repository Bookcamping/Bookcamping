# User
#
# 
class User < ActiveRecord::Base
  include Extensions::Roles
  include Extensions::UserOps
  include Extensions::Slug
  include Users::Create
  include Users::Identities

  has_slug :name

  # TAGS
  has_many :taggings, dependent: :destroy

  has_many :identities, dependent: :destroy
  has_many :books, dependent: :restrict
  has_many :comments, dependent: :destroy
  has_many :versions, foreign_key: :whodunnit
  has_many :taggins
  has_many :tags, through: :taggins

  # Shelves
  has_many :shelves, dependent: :restrict
  has_many :camp_shelves
  has_many :user_shelves, dependent: :destroy

  # Profile shelves
  has_one :like_it_shelf, class_name: 'UserShelf', conditions: {rol: 'like_it'}
  has_one :read_later_shelf, class_name: 'UserShelf', conditions: {rol: 'read_later'}
  has_one :my_references_shelf, class_name: 'UserShelf', conditions: {rol: 'my_references'}

  # Validations
  validates :name, presence: true, uniqueness: true
  #  validates :email, presence: true, on: :create, unless: :twitter?
  #  validates :email, uniqueness: true, if: :email?
  # validates :password, presence: true, confirmation: true, on: :create
  # validates :password_confirmation, presence: true, on: :create

  #has_secure_password

  # Callbacks
  after_create :create_profile_shelves

  attr_accessor :password, :password_confirmation

end
