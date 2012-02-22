class MergeUsersAndIdentities < ActiveRecord::Migration
  def up
    remove_column :users, :email_confirmed
    remove_column :users, :email_visible
    remove_column :users, :twitter_visible
    remove_column :users, :active

    add_column :users, :settings, :string, limit: 300
    add_column :users, :password_digest, :string
    add_column :users, :uid_twitter, :string
    add_column :users, :uid_facebook, :string
    add_column :users, :uid_google, :string
    add_column :users, :recovery_code, :string

    say_with_time('Updating users...') do
      User.all.each do |user|
        say("User #{user.name}: #{user.old_identities.size} identidades.")
        user.old_identities.each do |id|
          if id.provider == 'twitter'
            user.uid_twitter = id.uid
          elsif id.provider == 'google'
            user.uid_google = id.uid
          elsif id.provider == 'facebook'
            user.uid_facebook = id.uid
          elsif id.provider == 'bookcamping'
            user.password_digest = id.password_digest
          elsif id.provider == 'recovery'
            user.recovery_code == id.uid
          end
          #id.destroy
        end
        user.save(validate: false)
      end
    end


  end

  def down
  end
end
