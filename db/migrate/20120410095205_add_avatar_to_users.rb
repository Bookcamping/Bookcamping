class AddAvatarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string, limit: 300
  end
end
