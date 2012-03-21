class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :resource, polymorphic: true
      t.belongs_to :user
      t.timestamps
    end

    add_index :memberships, :user_id
    add_index :memberships, [:resource_type, :resource_id]
  end
end
