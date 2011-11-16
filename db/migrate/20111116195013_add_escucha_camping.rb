class AddEscuchaCamping < ActiveRecord::Migration
  def change
    remove_column :camps, :subdomain
    remove_column :camps, :line1
    remove_column :camps, :line2
    remove_column :camps, :origin

    Camp.create!(name: 'escucha', model_name: 'escucha')
  end
end
