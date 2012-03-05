# encoding: utf-8
class PublishedReferencesController < ApplicationController

  expose(:publisher) { Publisher.find params[:publisher_id] }
  expose(:references) { Reference.where(publisher_id: nil).order('title ASC') }
  expose(:reference) { Reference.find(params[:reference_id]) }
  expose(:search) { Search.new(:references, references, params[:title]) }


  def new
    authorize! :manage, publisher
  end

  def create
    authorize! :manage, publisher
    publisher.add_reference(reference)
    redirect_to publisher, notice: 'Referencia añadida'
  end
end