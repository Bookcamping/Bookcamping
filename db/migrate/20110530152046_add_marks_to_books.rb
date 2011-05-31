class AddMarksToBooks < ActiveRecord::Migration
  def change
    add_column :books, :like_it_marks, :integer, :default => 0
    add_column :books, :read_later_marks, :integer, :default => 0



    Book.all.each do |book|
      Book.paper_trail_off
      book.user_id = 3 unless book.user_id?
      book.like_it_marks = book.bookmarks.like_it.count
      book.read_later_marks = book.bookmarks.read_later.count
      book.save!
    end
  end

  protected
  def bookmark_count(book, name)
    book.marks ||= {}
    book.marks[name] ||= 0
    book.marks[name]
  end

  def update_bookmark(book, name, delta)
    actual = bookmark_count book, name
    book.marks[name] = actual + delta
    book.save
  end

end
