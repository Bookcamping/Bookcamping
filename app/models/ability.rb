class Ability
  include CanCan::Ability

  def initialize(provided_user)
    self.user = provided_user

    cannot :create, Shelf if anonymous?

    can :create, Bookmark if user?

    can :manage, Book if user?
    cannot :destroy, Book unless admin?

    # User
    can :read, User
    can :edit, User, id: user.id

    can :manage, ShelfItem do |item|
      can :manage, item.shelf
    end

    can :manage, Shelf do |shelf|
      if shelf.type == 'CampShelf'
        true
      elsif shelf.user_id == user.id and shelf.rol != 'my_references'
        true
      else
        false
      end
    end
#    can :manage, :all if admin?

    # UserShelf
    can :read, UserShelf
    cannot :destroy, UserShelf, :rol => 'read_later'
    cannot :destroy, UserShelf, :rol => 'like_it'
    cannot :destroy, UserShelf, :rol => 'my_references'

    can :manage, Post if user.admin?
    can :read, Post
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

  def admin?
    user? and @user.admin?
  end

  def super?
    user? and @user.super?
  end
end
