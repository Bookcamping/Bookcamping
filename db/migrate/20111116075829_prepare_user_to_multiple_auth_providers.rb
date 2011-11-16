class PrepareUserToMultipleAuthProviders < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean, default: false

    User.all.each do |user|
      user.twitter_visible = true
      user.active = false
      user.active = true if user.books.count > 0
      user.active = true if user.user_shelves.count > 0
      user.active = true if user.profile_shelves.count > 0
      user.active = true if user.comments.count > 0
      user.save
    end
  end
end
