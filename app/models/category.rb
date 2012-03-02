class Category < ActiveRecord::Base
  extend FriendlyId

  # EXTENSIONS
  friendly_id :name, use: :slugged
  #has_paper_trail meta: {title: :name }

  # RELATIONS
  has_many :pages

  # CONSTANTS
  LEVELS = [:public, :admin]

  def viewable?(user)
    if view_level == 'public'
      true
    else
      user.try(:admin?)
    end
  end

  def editable?(user)
    if view_level == 'public'
      user.present?
    else
      user.try(:admin?)
    end
  end

end
