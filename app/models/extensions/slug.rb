module Extensions
  module Slug
    extend ActiveSupport::Concern

    module ClassMethods
      # TODO: refactor to hash param
      def has_slug(param = :name)
        before_save do
          if param
            self.slug = send(param).parameterize
          else
            self.slug = self.slug.parameterize
          end
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

