class User::SetupUser
  # @param camp [Camp]
  # @param user [User]
  def initialize(user)
    @user = user
  end

  def user
    @user
  end

  def create_profile_shelves
    PaperTrail.enabled = false

    unless user.like_it_shelf
      UserShelf.create!(slug: 'favoritos', user: user, name: 'FAVORITOS',
                           visibility: :public, rol: 'like_it', color: '#44adc6')
    end

    unless user.read_later_shelf
      UserShelf.create!(slug: 'para_leer', user: user, name: 'PARA LEER',
                           visibility: :private, rol: 'read_later', color: '#67c095')
    end

    unless user.my_references_shelf
      UserShelf.create!(slug: 'mis_aportaciones', user: user, name: 'MIS APORTACIONES',
                           visibility: :public, rol: 'my_references', color: '#e7de21')
    end

    PaperTrail.enabled = true
  end
end


