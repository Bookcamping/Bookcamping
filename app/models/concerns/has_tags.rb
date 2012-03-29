module HasTags
  extend ActiveSupport::Concern

  included do
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
  end

  # Add tag to a reference
  def add_tag(reference, tag_name)
    tag = Tag.find_by_slug tag_name.parameterize
    tag ||= Tag.create name: tag_name
    tg = Tagging.new(user:self, reference:reference,tag:tag)
    tg.save ? tg : nil
  end
end
