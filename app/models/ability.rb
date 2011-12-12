class Ability
  include CanCan::Ability

  def initialize(provided_user)
    self.user = provided_user

    camps
    users
    references
    shelves
    shelf_items
    user_shelves
    posts
    licenses
    tags
  end

  def camps
    can :manage, Camp if user.admin?
  end

  def users
    can :read, User
    can :edit, User, id: user.id
  end

  def references
    can :manage, Book if user?
    cannot :destroy, Book unless user.admin?
  end

  def shelves
    cannot :create, Shelf if anonymous?
    can :manage, Shelf do |shelf|
      if shelf.type == 'CampShelf'
        true
      elsif shelf.user_id == user.id and shelf.rol != 'my_references'
        true
      else
        false
      end
    end
  end

  def shelf_items
   can :manage, ShelfItem do |item|
      can :manage, item.shelf
    end
 end


  def posts
    can :manage, Post if user.admin?
    can :read, Post
  end

  def user_shelves
    can :read, UserShelf
    cannot :destroy, UserShelf, :rol => 'read_later'
    cannot :destroy, UserShelf, :rol => 'like_it'
    cannot :destroy, UserShelf, :rol => 'my_references'
  end

  def licenses
    can :read, License
  end

  def tags
    can :read, Tag
  end

  def user=(user)
    @user = user || User.new
  end

  def anonymous?
    @user.new_record?
  end

  def user
    @user
  end

  def user?
    !anonymous?
  end
end
