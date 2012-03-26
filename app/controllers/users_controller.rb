# encoding: utf-8
class UsersController < ApplicationController
  respond_to :html

  expose_with_slug
  expose_resource :user
  expose(:user_count) { User.count }
  expose(:users) { User.all }
  expose(:user)
  expose(:persons) { User.persons.order('last_login_at DESC').limit(50) }
  expose(:groups) { User.groups }

  expose(:shelf_order) { Shelf::Order.new(params[:o]) }
  expose(:shelves) { shelf_order.order user.shelves.public }
  expose(:search) { Search.new(:users, users, params[:term]) }

  def index
    authorize! :read, User
  end

  def new
    new!
  end

  expose(:references) { user.references.limit(10).reorder('created_at DESC')}
  def show
    show!
  end

  def edit
    edit!
  end

  def create
    if current_user
      user.group = true
      if user.save
        user.add_member(current_user)
        flash[:notice] = 'Colectivo creado'
      end
    else
      if user.save
        self.current_user = user
        user.audit_login
        flash[:notice] = "¡Bienvenidx #{user.name}!"
      else
        puts user.errors.inspect
      end
    end
    respond_with user
  end

  def update
    update! [user]
  end

  def destroy
    destroy!
  end
end

