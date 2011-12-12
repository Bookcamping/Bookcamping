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
    end
  end
end

