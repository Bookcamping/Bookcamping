class CreateCamps < ActiveRecord::Migration
  def change

    PaperTrail.enabled = false

    create_table :camps do |t|
      t.string :name, :limit => 100
      t.string :subdomain, :limit => 100
      t.string :line1, :limit => 200
      t.string :line2, :limit => 200
      t.timestamps
    end

    referencecamp = Camp.create!(:subdomain => 'reference', :name => '#referencecamp')
    puts "CAMP #{referencecamp.id}"
    Camp.create!(:subdomain => 'video', :name => '#videocamp')

    add_column :references, :camp_id, :integer
    add_column :camp_shelves, :camp_id, :integer
    add_column :shelf_items, :camp_id, :integer
    add_column :comments, :camp_id, :integer
    add_column :versions, :camp_id, :integer
    add_index :references, :camp_id
    add_index :camp_shelves, :camp_id
    add_index :shelf_items, :camp_id
    add_index :comments, :camp_id
    add_index :versions, :camp_id

    Reference.find_each do |model|
      model.update_attribute(:camp_id, referencecamp.id)
    end
    Shelf.find_each do |model|
      model.update_attribute(:camp_id, referencecamp.id)
    end
    ShelfItem.find_each do |model|
      model.update_attribute(:camp_id, referencecamp.id)
    end
    Comment.find_each do |model|
      model.update_attribute(:camp_id, referencecamp.id)
    end
    Version.find_each do |model|
      model.update_attribute(:camp_id, referencecamp.id)
    end
  end
end
