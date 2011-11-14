class User::MembershipSetup
  # @param camp [Camp]
  # @param user [User]
  def initialize(camp, user)
    @camp = camp
    @user = user
  end

  def setup_membership
    PaperTrail.enabled = false

    unless @user.memberships.by_camp(@camp).present?
      Membership.create!(user: @user, camp: @camp)
    end

    unless @user.profile_shelves.by_camp(@camp).by_rol('like_it')
      ProfileShelf.create!(camp: @camp, user: @user, name: 'FAVORITOS',
                           visibility: :public, rol: 'like_it', color: '#44adc6')
    end

    unless @user.profile_shelves.by_camp(@camp).by_rol('read_later')
      ProfileShelf.create!(camp: @camp, user: @user, name: 'PARA LEER',
                           visibility: :private, rol: 'read_later', color: '#67c095')
    end

    setup_my_references
    PaperTrail.enabled = true
  end

  def setup_my_references
    PaperTrail.enabled = false
    unless @user.profile_shelves.by_camp(@camp).by_rol('my_references')
      refs = ProfileShelf.create! do |s|
        s.camp = @camp
        s.user = @user
        s.name = 'MIS APORTACIONES'
        s.visibility = :public
        s.rol = 'my_references'
        s.color = '#e7de21'
      end

      @user.books.by_camp(@camp).each do |book|
        refs.add_book(book, @user)
      end
    end
    PaperTrail.enabled = true
  end
end


