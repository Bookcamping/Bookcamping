class ChangeLicenseBodyType < ActiveRecord::Migration
  def change
    remove_column :licenses, :body
    add_column :licenses, :body, :text
  end
end
