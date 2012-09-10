# Camp
# Es un camping dentro de bookcamping. Originalmente fueron
# dos: bookcamping y videocamping. En la actualidad hay más y se
# pueden crear sobre la marcha.
#
class Camp < ActiveRecord::Base
  # EXTENSIONS
  include HasGroup
  include BooleanAccessor
  extend FriendlyId
  friendly_id :name

  # Relations
  belongs_to :user
  has_many :shelves
  has_many :camp_shelves
  has_many :curated_shelves
  has_many :user_shelves
  has_many :shelf_items
  has_many :references
  has_many :comments
  has_many :referencemarks
  has_many :versions

  # Validations
  validates :user_id, presence: true
  validates :name, presence: true
  validates :slug, presence: true

  store :settings, accessors: [:description, :has_blog, :lock_camp_shelves, :last_activity_email ]
  boolean_accessor [:has_blog, :lock_camp_shelves ]


  module Scopes
    def by_camp(camp)
      where(camp_id: camp.id)
    end
  end
  extend Scopes


end
