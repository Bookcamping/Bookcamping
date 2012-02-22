class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    camps
    users
    references
    shelves
    shelf_items
    user_shelves
    posts
    publishers
    misc
  end

  def publishers
    can :read, Publisher
    can :manage, Publisher if is? :admin
  end

  def camps
    can :manage, Camp if is? :admin
  end

  def users
    can :read, User
    can :new, User unless @user
    can :create, User unless @user
    can :destroy, User if is? :super
    can :update, user {|u| @user.id = u.id or is? :admin }
  end

  def references
    can :manage, Book if @user
    cannot :destroy, Book unless is? :admin
  end

  def shelves
    can :read, CampShelf
    can :manage, CampShelf if user?
    cannot :destroy, CampShelf unless user.admin?
  end

  def shelf_items
   can :manage, ShelfItem do |item|
      can :manage, item.shelf
    end
 end


  def posts
    can :manage, Post if is? :admin
    can :read, Post
  end

  def user_shelves
    can :read, UserShelf
    cannot :destroy, UserShelf, :rol => 'read_later'
    cannot :destroy, UserShelf, :rol => 'like_it'
    cannot :destroy, UserShelf, :rol => 'my_references'
  end

  def misc
    can :read, Tag
    can :manage, Tagging
    can :read, License
    #can :read, Version
    #can :manage, Version if is? :admin
    can :manage, MediaBite if is? :admin
  end

  def user
    @user
  end

  def is?(rol)
    @user and @user.send("#{rol}?")
  end
end
