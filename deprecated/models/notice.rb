class Notice < ActiveRecord::Base
  default_scope order: 'published_at DESC'

  validates :body, presence: true
  validates :level, presence: true
  validates :published_at, presence: true

end
