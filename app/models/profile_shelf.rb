# ProfileShelf
#
# Predefined user shelves. Currently like_it and read_later
# Has different behaviour (for example: they update some statistics 
# on references) and can't be deleted by user
#
class ProfileShelf < Shelf
  validates :rol, presence: true

  ROLES = ['like_it', 'read_later', 'my_references']
  PARAMS = ['favoritos', 'para_leer', 'aportaciones']
  ROL_TO_PARAM = Hash[ROLES.zip(PARAMS)]
  PARAM_TO_ROL = Hash[PARAMS.zip(ROLES)]

  # Define some relation scopes
  module Scopes
    def by_rol(rol)
      where(rol: rol).first
    end

    def by_param(param)
      if PARAMS.include?(param)
        by_rol(PARAM_TO_ROL[param])
      else
        by_rol('-')
      end
    end
  end
  extend Scopes

  def add_book(book)
    ShelfItem.create!(shelf: self, book: book, user: self.user)
    book.update_bookmark(self.rol, 1)
  end


  def to_param
    "#{ROL_TO_PARAM[self.rol]}"
  end

end
