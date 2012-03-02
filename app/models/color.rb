# Color
#
class Color < ActiveRecord::Base


  validates :name, presence: true
  validates :value, presence: true


  def self.collection
    Color.all.map do |color|
      [color.name, color.value]
    end
  end
end
