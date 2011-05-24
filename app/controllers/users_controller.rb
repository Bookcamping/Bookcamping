class UsersController < ApplicationController
  respond_to :html
  expose(:users) { User.all }
  expose(:user)

  def index

  end
end
