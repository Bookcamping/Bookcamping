class RemoveProfileShelves < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false
    puts "Users: #{User.all.count}"
    puts "Creating user shelves..."
    User.all.each do |user|
      User::SetupUser.new(user).create_profile_shelves
    end

    PaperTrail.enabled = false
    puts "Adding references to shelves..."
    User.all.each do |user|
      refs = user.my_references_shelf
      user.references.each do |reference|
        refs.add_reference(reference)
      end
    end

    PaperTrail.enabled = false
    puts "Destroying profile shelves"
    ProfileShelf.destroy_all
  end

  def down
  end
end
