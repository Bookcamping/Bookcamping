class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :camp
      t.string :rol, :limit => 8
      t.timestamps
    end

    add_column :users, :login_count, :integer, :default => 0
    add_column :users, :last_login_at, :datetime

    Reference.all.each do |reference|
      reference.user.membership(reference.camp)
    end

  end
end
