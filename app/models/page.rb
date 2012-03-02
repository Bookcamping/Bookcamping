class Page < ActiveRecord::Base
  extend FriendlyId

  # EXTENSIONS
  friendly_id :title, use: :slugged
  has_paper_trail meta: {title: :title }

  # CONSTANTS
  CATEGORIES = [:public, :wip, :site, :licenses]

  belongs_to :user
  belongs_to :category

  validates :title, presence: true
  validates :content_type, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true

end
