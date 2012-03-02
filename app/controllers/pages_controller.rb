# encoding: utf-8

class PagesController < ApplicationController
  before_filter :require_user, except: [:index, :show]
  respond_to :html

  expose(:categories) { Category.where(section: '').includes(:pages)}
  expose(:category) { Category.find(params[:en]) if params[:en].present? }

  expose_resource :page
  expose(:pages) { Page.order('updated_at DESC').includes(:category) }
  expose(:page)

  def index
    index!
  end

  def show
    show!
  end

  def new
    page.category = category || Category.find(1)
    new!
  end

  def edit
    edit!
  end

  def create
    page.user = current_user
    page.content_type ||= 'markdown'
    page.category_id ||= 1
    flash[:notice] = 'Página guardada' if page.save
    respond_with page, location: page
  end

  def update
    page.category_id ||= 1
    flash[:notice] = 'Página guardada' if page.save
    respond_with page
  end

  def destroy
    destroy! pages_path
  end
end