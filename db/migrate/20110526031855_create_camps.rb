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

    bookcamp = Camp.create!(:subdomain => 'book', :name => '#bookcamp')
    puts "CAMP #{bookcamp.id}"
    Camp.create!(:subdomain => 'video', :name => '#videocamp')

    add_column :books, :camp_id, :integer
    add_column :shelves, :camp_id, :integer
    add_column :shelf_items, :camp_id, :integer
    add_column :comments, :camp_id, :integer
    add_column :versions, :camp_id, :integer
    add_index :books, :camp_id
    add_index :shelves, :camp_id
    add_index :shelf_items, :camp_id
    add_index :comments, :camp_id
    add_index :versions, :camp_id

    Book.find_each do |model|
      model.update_attribute(:camp_id, bookcamp.id)
    end
    Shelf.find_each do |model|
      model.update_attribute(:camp_id, bookcamp.id)
    end
    ShelfItem.find_each do |model|
      model.update_attribute(:camp_id, bookcamp.id)
    end
    Comment.find_each do |model|
      model.update_attribute(:camp_id, bookcamp.id)
    end
    Version.find_each do |model|
      model.update_attribute(:camp_id, bookcamp.id)
    end
  end
end
