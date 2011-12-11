module Extensions
  module UserOps
    extend ActiveSupport::Concern

    module InstanceMethods
      # Add book to my_references_shelf
      def add_book(book)
        book.user = self
        User.transaction do
          book.save
          self.my_references_shelf.add_book(book)
          return true
        end
        return false
      end

      # Add a tag to a reference
      def tag(reference, name)
        slug = name.to_s.parameterize
        tag = Tag.find_by_slug slug
        tag ||= Tag.create(name: name)
        Taggin.create(user: self, tag: tag, reference: reference)
      end
    end
  end
end

