class CleanUsersRemoveMemberships < ActiveRecord::Migration
  def change
    PaperTrail.enabled = false

    puts "Removing memberships"
    drop_table :memberships

    PaperTrail.enabled = false
    puts "Users: #{User.all.count}"
    puts "Removing inactive users..."
    User.all.each do |user|
      if user.references.count == 0
        user.shelves.destroy_all
        user.destroy
      end
    end


  end
end
