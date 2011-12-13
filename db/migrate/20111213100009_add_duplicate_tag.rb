class AddDuplicateTag < ActiveRecord::Migration
  def up
    user = User.find 284

    Book.all.each do |book|
      if Book.where(title: book.title).count > 1
        user.add_tag book, 'duplicados'
      end
    end
  end

  def down
  end
end
