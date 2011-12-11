# Post
# Una entrada al blog de bookcamping.
#
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :resource, :order => 'id DESC', :dependent => :destroy

  # SCOPES
  scope :published, where(visibility: 'published')

  # CONSTANTS
  VISIBILITIES = [:draft, :published]
  CONTENT_TYPES = [:markdown, :html]

  # VALIDATIONS
  validates :user_id, presence: true
  validates :author, presence: true
  validates :title, presence: true, uniqueness: true
  validates :visibility, presence: true

  # CALLBACKS
  before_save :update_slug, :clean_visibility

  def published?
    self.visibility == 'published'
  end

  # TODO: extract to module
  def self.by_param(param)
    Post.find_by_slug(param) || Post.find(param)
  end

  def to_param
    slug
  end

  protected
  def update_slug
    self.slug = title.parameterize
  end

  def clean_visibility
    self.visibility = self.visibility.to_s
    self.visibility = 'draft' unless self.visibility == 'published'
  end
end
