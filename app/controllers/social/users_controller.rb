# encoding: utf-8
class Social::UsersController < ApplicationController
  respond_to :html

  expose_with_slug
  expose_resource :user
  expose(:users) { User.order('login_count DESC').limit(100) }
  expose(:shelf_order) { Shelf::Order.new(params[:o]) }
  expose(:shelves) { shelf_order.order user.shelves.public }
  expose(:search) { Search.new(:users, users, params[:term]) }

  def index
    authorize! :read, User
  end

  def new
    user.identities.build(provider: 'bookcamping') 
    new!
  end

  def show
    show!
  end

  def edit
    edit!
  end

  def create
    user = User.new params[:user]
    if user.save
      self.current_user = user
      user.audit_login
      flash[:notice] = "¡Bienvenidx #{user.name}!"
    end
    respond_with user
  end

  def update
    update! [user]
  end
end

