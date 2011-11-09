class Ability
  include CanCan::Ability

  def initialize(provided_user)
    self.user = provided_user

    can :manage, :all if admin?
    can :manage, Shelf, :user_id => @user.id
    cannot :create, Shelf if anonymous?
    can :create, ShelfItem if user?

    can :create, Bookmark if user?

    can :manage, Book if user?
    cannot :destroy, Book unless admin?

    can :edit, User, id: @user.id
  end

  def user=(user )
    @user = user || User.new
  end

  def anonymous?
     @user.new_record?
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