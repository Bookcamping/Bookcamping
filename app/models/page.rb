class Page < ActiveRecord::Base
  extend FriendlyId

  # EXTENSIONS
  friendly_id :title, use: :slugged
  has_paper_trail meta: {title: :title }



  belongs_to :user

  validates :title, presence: true
  validates :content_type, presence: true
  validates :user_id, presence: true
  validates :view_level, presence: true
  validates :edit_level, presence: true


end
