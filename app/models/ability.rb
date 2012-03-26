class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :view, to: :read

    can :read, Camp, closed: false
    can :read, User
    can :read, Reference
    can :read, License
    can(:read, Category) {|category| category.viewable?(user) }
    can(:read, Page) {|page| page.category.viewable?(user) }
    can :read, Publisher
    can :read, Post

    can :read, CampShelf
    can :read, UserShelf

    can :read, Tag


    if user.present?
      can :update, Camp do |camp|
        camp.member?(user)
      end
      can :create, User
      can :manage, User, id: user.id
      can :update, License

      can :create, Reference
      can :manage, Reference, publisher_id: nil

      can :create, Page
      can(:update, Page) {|page| page.category.editable?(user) }

      can :add_to, CampShelf
      can :create, UserShelf
      can(:add_to, UserShelf) {|shelf| shelf.open? or shelf.members.include?(user)}
      can :manage, UserShelf, user_id: user.id

      can(:manage, ShelfItem) {|item| can? :add_to, item.shelf }
      can(:manage, ShelfMember) {|member| can? :manage, member.shelf }

      can :manage, Tagging
      can :create, Tag

      if user.admin?
        can :manage, Camp
        can :update, User
        can :manage, License
        can :manage, Category
        can :manage, Page
        can :manage, Color
        can :manage, Publisher
        can :manage, CampShelf
        can :manage, UserShelf
        can :manage, Post
        can :manage, MediaBite
        can :manage, ShelfMember
      end

      if user.super?
        can :manage, User
      end
    end
  end
end
