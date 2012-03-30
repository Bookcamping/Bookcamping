class MembershipsController < ApplicationController
  respond_to :html

  expose(:user) { User.find(params[:user_id]) if params[:user_id] }
  expose(:camp_shelf) { CampShelf.find(params[:camp_shelf_id]) if params[:camp_shelf_id] }
  expose(:user_shelf) { UserShelf.find(params[:user_shelf_id]) if params[:user_shelf_id] }
  expose(:parent) { user || (camp_shelf || user_shelf) }
  expose(:search) { Search.new(:users, User.reorder('last_login_at DESC'), params[:user_name]) }
  expose(:member) { User.find params[:member_id] }
  expose_resource :membership
  expose(:memberships) { parent.memberships }
  expose(:membership)

  def index
    authorize! :read, Membership
  end

  def new
    authorize! :new, Membership
  end

  def create
    authorize! :manage, parent
    m = Membership.create(resource: parent, user: member)
    respond_with m, location: [parent, :memberships]
  end

  def destroy
    authorize! :manage, parent
    membership.destroy
    respond_with membership, location: [parent, :memberships]
  end
end
