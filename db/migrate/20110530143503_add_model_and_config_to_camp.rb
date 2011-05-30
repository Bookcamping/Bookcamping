class AddModelAndConfigToCamp < ActiveRecord::Migration
  def change
    add_column :camps, :model_name, :string, :limit => 32
    add_column :camps, :origin, :string, :limit => 256
    add_column :camps, :show_media_on_lists, :boolean, :default => false

    Camp.find(1).update_attribute(:model_name, 'libro')
    Camp.find(2).update_attributes({:model_name => 'video', :show_media_on_lists => true})
  end
end
