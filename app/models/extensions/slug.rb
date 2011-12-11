module Extensions
  module Slug
    extend ActiveSupport::Concern

    module ClassMethods
      def has_slug(param = :name)
        before_save do
          self.slug = send(param).parameterize
        end
      end

      def find_by_param(value)
        self.find_by_slug(value) || self.find(value)
      end
    end

    def to_param
      slug
    end
  end
end

