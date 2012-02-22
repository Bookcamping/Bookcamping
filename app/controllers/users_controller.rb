# encoding: utf-8
class UsersController < ApplicationController
  respond_to :html

  expose_with_slug
  expose_resource :user
  expose(:users) { User.order('login_count DESC').limit(100) }
  expose(:user)

  expose(:shelf_order) { Shelf::Order.new(params[:o]) }
  expose(:shelves) { shelf_order.order user.shelves.public }
  expose(:search) { Search.new(:users, users, params[:term]) }

  def index
    authorize! :read, User
  end

  def new
    new!
  end

  def show
    show!
  end

  def edit
    edit!
  end

  def create
    if user.save
      self.current_user = user
      user.audit_login
      flash[:notice] = "¡Bienvenidx #{user.name}!"
    else
      puts user.errors.inspect
    end
    respond_with user, location: root_path
  end

  def update
    update! [user]
  end
end

