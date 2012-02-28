class MoveBookmarksToProfileLists < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false

    Reference.all.each do |reference|
      puts "#{reference.title} (#{reference.like_it_marks}/#{reference.read_later_marks})"
      reference.update_attribute(:like_it_marks, 0)
      reference.referencemarks do |mark|
        shelf = ProfileShelf.where(camp_id: mark.camp_id).
            where(user_id: mark.user_id).where(rol: mark.name).first
        shelf.add_reference(mark.reference, mark.user)
      end
      puts "#{reference.title} (#{reference.like_it_marks}/#{reference.read_later_marks})"
    end
  end

  def down
  end
end
