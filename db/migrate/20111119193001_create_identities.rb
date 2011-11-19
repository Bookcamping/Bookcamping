class CreateIdentities < ActiveRecord::Migration
  def change
    say_with_time "Creando tabla de indentidades..." do
      create_table :identities do |t|
        t.string :uid
        t.belongs_to :user
        t.string :provider
        t.string :password_digest
        t.timestamps
      end
    end

    say_with_time "Creando identidades para cada usuario..." do
      User.all.each do |user|
        if user.provider
          Identity.create(user: user, uid: user.uid, provider: user.provider)
        else
          Identity.create(user: user, uid: user.email, provider: 'bookcamping', password_digest: user.password_digest)
        end
      end
    end

    say_with_time "Limpiando campos del modelo user..." do

      remove_column :users, :uid
      remove_column :users, :provider
      remove_column :users, :facebook_uid
      remove_column :users, :twitter_uid
      remove_column :users, :google_uid
      remove_column :users, :password_digest
      remove_column :users, :password_salt
    end
  end
end
