class Social::UsersController < ApplicationController
  respond_to :html
  expose(:users) { User.order('login_count DESC').limit(100) }
  expose(:user)
  expose(:shelves) { user.public_shelves }

  def index
  end

  def show
    User::MembershipSetup.new(current_camp, user).setup_my_references
  end
end

