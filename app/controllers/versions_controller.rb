class VersionsController < ApplicationController
  respond_to :html, :js, :json

  expose(:versions) do
    v = Version.scoped
    v = v.where(camp_id: current_camp.id)
    v = v.order('id DESC')
    v = v.limit(50)
    v
  end

  def index
    respond_with versions   
  end
end

