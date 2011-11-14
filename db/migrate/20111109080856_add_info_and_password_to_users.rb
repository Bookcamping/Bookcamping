class AddInfoAndPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :twitter, :string, limit: 150
    add_column :users, :email_visible, :boolean, default: false
    add_column :users, :twitter_visible, :boolean, default: false
    add_column :users, :description, :string, limit: 300
    add_column :users, :password_digest, :string
    add_column :users, :password_salt, :string
    add_column :users, :twitter_uid, :string
    add_column :users, :google_uid, :string
    add_column :users, :facebook_uid, :string

    PaperTrail.enabled = false
    User.all.each do |user|
      column = "#{user.provider}_uid"
      user.send(column, user.uid)
      user.save!
    end

  end
end
