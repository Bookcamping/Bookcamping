class Social::UsersController < ApplicationController
  respond_to :html
  expose(:users) { User.where('login_count > 1').order('updated_at DESC') }
  expose(:user)
  expose(:shelves) { user.public_shelves }

  def index
  end

  def show
    User::MembershipSetup.new(current_camp, user).setup_my_references
  end
end

