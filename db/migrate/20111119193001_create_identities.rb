class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.belongs_to :user
      t.string :provider
      t.string :password_digest
      t.timestamps
    end

    User.all.each do |user|
      Identity.create!(user: user, uid: user.uid, provider: user.provider)
    end

    remove_column :users, :uid
    remove_column :users, :provider
    remove_column :users, :facebook_uid
    remove_column :users, :twitter_uid
    remove_column :users, :google_uid
    remove_column :users, :password_digest
    remove_column :users, :password_salt
  end
end
