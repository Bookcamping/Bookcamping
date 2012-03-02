class Category < ActiveRecord::Base
  extend FriendlyId

  # EXTENSIONS
  friendly_id :name, use: :slugged
  #has_paper_trail meta: {title: :name }

  # RELATIONS
  has_many :pages

end
