class AddMarksToBooks < ActiveRecord::Migration
  def change
    add_column :references, :like_it_marks, :integer, :default => 0
    add_column :references, :read_later_marks, :integer, :default => 0



    Reference.all.each do |reference|
      Reference.paper_trail_off
      reference.user_id = 3 unless reference.user_id?
      reference.like_it_marks = reference.referencemarks.like_it.count
      reference.read_later_marks = reference.referencemarks.read_later.count
      reference.save!
    end
  end

  protected
  def referencemark_count(reference, name)
    reference.marks ||= {}
    reference.marks[name] ||= 0
    reference.marks[name]
  end

  def update_referencemark(reference, name, delta)
    actual = referencemark_count reference, name
    reference.marks[name] = actual + delta
    reference.save
  end

end
