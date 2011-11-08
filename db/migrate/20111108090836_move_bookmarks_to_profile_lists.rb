class MoveBookmarksToProfileLists < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false

    Book.all.each do |book|
      puts "#{book.title} (#{book.like_it_marks}/#{book.read_later_marks})"
      book.update_attribute(:like_it_marks, 0)
      book.bookmarks do |mark|
        shelf = ProfileShelf.where(camp_id: mark.camp_id).
            where(user_id: mark.user_id).where(rol: mark.name).first
        shelf.add_book(mark.book, mark.user)
      end
      puts "#{book.title} (#{book.like_it_marks}/#{book.read_later_marks})"
    end
  end

  def down
  end
end
