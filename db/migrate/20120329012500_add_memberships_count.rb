class AddMembershipsCount < ActiveRecord::Migration
  def change
    add_column :camps, :memberships_count, :integer, default: 0
    add_column :pages, :memberships_count, :integer, default: 0
    add_column :shelves, :memberships_count, :integer, default: 0
    add_column :users, :memberships_count, :integer, default: 0

    User.all.each do |user|
      user.update_attribute(:memberships_count, user.memberships.count)
    end
  end

end
