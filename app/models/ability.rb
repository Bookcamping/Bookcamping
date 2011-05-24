class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all if user.super?

    can :new, BookList unless user.new_record?
    can :manage, BookList, :user_id => user.id

    can :manage, Book, :user_id => user.id

  end
end