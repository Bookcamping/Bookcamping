# encoding: utf-8

class PagesController < ApplicationController
  respond_to :html
  expose_resource :page
  expose(:pages) { Page.all }
  expose(:page)

  def index
    index!
  end

  def show
    show!
  end

  def new
    new!
  end

  def edit
    edit!
  end

  def create
    page.user = current_user
    page.content_type ||= 'markdown'
    page.view_level ||= 'public'
    page.edit_level ||= 'public'
    flash[:notice] = 'Página guardada' if page.save
    respond_with page, location: page
  end

  def update
    update! page_path(page)
  end

  def destroy
    destroy! pages_path
  end
end