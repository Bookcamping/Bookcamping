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

      # Add tag to a book
      def add_tag(book, tag_name)
        tag = Tag.find_by_slug tag_name.parameterize
        tag ||= Tag.create name: tag_name
        tg = Tagging.new(user:self, reference:book,tag:tag)
        tg.save ? tg : nil
      end
    end
    
  end
end

