# User
#
class User < ActiveRecord::Base
  # Extensions
  extend FriendlyId
  friendly_id :name, use: :slugged
  include Identifiable
  include HasRoles
  include HasMembers

  # RELATIONS 
  has_many :references, dependent: :restrict
  has_many :comments, dependent: :destroy
  has_many :versions, foreign_key: :whodunnit
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :shelves, dependent: :restrict
  has_many :camp_shelves, dependent: :restrict
  has_many :user_shelves, dependent: :destroy

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  # validates :password, presence: true, confirmation: true, on: :create
  # validates :password_confirmation, presence: true, on: :create

  # Add reference to my_references_shelf
  def add_reference(reference)
    reference.user = self
    User.transaction do
      reference.save
      return true
    end
    return false
  end

  # Add tag to a reference
  def add_tag(reference, tag_name)
    tag = Tag.find_by_slug tag_name.parameterize
    tag ||= Tag.create name: tag_name
    tg = Tagging.new(user:self, reference:reference,tag:tag)
    tg.save ? tg : nil
  end

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
