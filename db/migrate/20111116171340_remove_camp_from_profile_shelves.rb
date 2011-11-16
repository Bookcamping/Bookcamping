class RemoveCampFromProfileShelves < ActiveRecord::Migration
  def change
    PaperTrail.enabled = false

    ProfileShelf.where(camp_id: 2).destroy_all
    User.all.each do |user|
      shelf = user.profile_shelves.where(rol: 'my_references').first
      shelf ||= ProfileShelf.create! do |shelf|
        shelf.user = user
        shelf.name = 'MIS APORTACIONES'
        shelf.visibility = :public
        shelf.rol = 'my_references'
        shelf.color = '#e7de21'
        shelf.camp_id = 1
      end

      user.books.where(camp_id: 2).each do |book|
        shelf.add_book(book)
      end
    end

    ProfileShelf.update_all camp_id: nil

    PaperTrail.enabled = true
  end
end
