
ActsAsTaggableOn::Tag.class_eval do
  include Extensions::Slug
  has_slug :name
end

