# User
#
class User < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Roles
  include Extensions::UserOps
  include Users::Create
  include Users::Identities

  friendly_id :name, use: :slugged

  # RELATIONS 
  has_many :identities, dependent: :destroy, inverse_of: :user
  has_many :books, dependent: :restrict
  has_many :comments, dependent: :destroy
  has_many :versions, foreign_key: :whodunnit
  has_many :taggins
  has_many :taggings, dependent: :destroy
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
  validates :email, presence: true, uniqueness: true
  # validates :password, presence: true, confirmation: true, on: :create
  # validates :password_confirmation, presence: true, on: :create

  # NESTED IDENTITIES IN FORMS
  accepts_nested_attributes_for :identities
  before_validation :initialize_identities, on: :create

  # Callbacks
  after_create :create_profile_shelves

  # HELPER METHODS
  def authorized_with?(password)
    identity = self.identities.find_by_provider('bookcamping')
    identity != nil and identity.authorized?(password)
  end

  def audit_login
    self.last_login_at = Time.now
    self.login_count ||= 0
    self.login_count = self.login_count + 1
    self.save(:validate => false)
  end

  private
  def initialize_identities
    identities.each do |i|
      i.uid = self.email if i.bookcamping?
    end
  end

end
