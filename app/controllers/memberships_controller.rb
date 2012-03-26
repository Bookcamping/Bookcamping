class MembershipsController < ApplicationController
  before_filter :require_user

  expose(:user) { User.find params[:user_id] }
  expose(:search) { Search.new(:users, User.reorder('last_login_at DESC'), params[:user_name]) }
  expose(:member) { User.find params[:member_id] }
  expose_resource :membership
  expose(:memberships) { user.memberships }
  expose(:membership)

  def new
    authorize! :manage, user
  end

  def create
    authorize! :manage, user
    Membership.create(resource: user, user: member)
    redirect_to user_path(user)
  end
end
