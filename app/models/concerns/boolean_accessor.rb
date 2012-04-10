# BooleanAccessor
# Adds a method with ? to any key (used with store)
#
module BooleanAccessor
  extend ActiveSupport::Concern

  module ClassMethods
    def boolean_accessor(keys)
      keys.each do |key|
        define_method("#{key}?") do
          send(key) != '0'
        end
      end
    end
  end
end
