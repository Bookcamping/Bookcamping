class Ability
  include CanCan::Ability

  def initialize(provided_user)
    self.user = provided_user
    can :manage, :all if super?

    can :create, BookList if user?
    can :edit, BookList, :user_id => @user.id

    can :edit, Book, :user_id => @user.id
  end

  def user=(user )
    @user = user || User.new
    puts "### USER #{@user.to_json} ES USER: #{user?}"
  end

  def anonymous?
     @user.new_record?
  end

  def user?
    !anonymous?
  end

  def super?
    user? and @user.super?
  end
end