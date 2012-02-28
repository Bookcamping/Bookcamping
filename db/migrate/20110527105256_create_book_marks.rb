class CreateBookMarks < ActiveRecord::Migration
  def change
    create_table :referencemarks do |t|
      t.belongs_to :reference
      t.belongs_to :user
      t.belongs_to :camp
      t.string :name

      t.timestamps
    end

    add_column :references, :marks, :string, :limit => 300

    add_index :referencemarks, :reference_id
    add_index :referencemarks, :user_id
    add_index :referencemarks, :camp_id
  end
end
