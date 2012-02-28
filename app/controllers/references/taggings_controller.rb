class References::TaggingsController < ApplicationController
  expose(:reference) { Reference.find params[:reference_id] }
  
  def create
    authorize! :create, Tagging
    current_user.add_tag(reference, params[:tag_name])
    redirect_to reference
  end

  def destroy
    authorize! :destroy, Tagging
    tagging = reference.taggings.find params[:id]
    tagging.destroy
    redirect_to reference
  end
end
