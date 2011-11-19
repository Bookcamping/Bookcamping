class AddSlugToUsers < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, limit: 100
    add_column :users, :slug, :string, limit: 100

    add_index :users, :slug

    User.all.each {|u| u.save}
  end
end
