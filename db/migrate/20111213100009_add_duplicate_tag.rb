class AddDuplicateTag < ActiveRecord::Migration
  def up
    user = User.find 284

    Reference.all.each do |reference|
      if Reference.where(title: reference.title).count > 1
        user.add_tag reference, 'duplicados'
      end
    end
  end

  def down
  end
end
