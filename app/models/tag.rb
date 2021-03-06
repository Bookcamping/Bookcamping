class Tag < ActiveRecord::Base
  include Extensions::Slug
  include Extensions::Counter

  has_many :taggings, dependent: :destroy
  has_many :references, through: :taggings, class_name: 'Reference', order: 'title ASC'

  has_counter :size
  has_slug :name

  # VALIDATIONS
  validates :name, presence: true, uniqueness: true

  before_save :normalize_name

  protected
  def normalize_name
    self.name = self.name.mb_chars.capitalize.to_s
  end
end
