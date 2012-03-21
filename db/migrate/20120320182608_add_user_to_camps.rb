class AddUserToCamps < ActiveRecord::Migration
  def change
    add_column :camps, :user_id, :integer
    Camp.update_all(user_id: 284)
  end
end
