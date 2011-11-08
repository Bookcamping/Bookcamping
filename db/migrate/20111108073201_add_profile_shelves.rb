class AddProfileShelves < ActiveRecord::Migration
  def up
    add_column :shelf_items, :mark, :string, limit: 32

    Camp.all.each do |camp|
      camp.users.each do |user|
        ProfileShelf.create!(camp: camp, user: user, name: 'FAVORITOS',
        visibility: :public, rol: :like_it, color: '#e9c54b')

        ProfileShelf.create!(camp: camp, user: user, name: 'PARA LEER',
        visibility: :public, rol: :read_later, color: '#67c095')
      end
    end

  end

  def down
    remove_column :shelf_items, :mark
    ProfileShelf.destroy_all
  end

end
