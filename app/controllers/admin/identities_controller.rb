class Admin::IdentitiesController < Admin::ApplicationController
  expose(:identities) { Identity.order('id DESC').limit(50) }
  expose(:identity)

  def index
  end

  def edit
  end
 
  def update
    identity.update_attributes(params[:identity])
    redirect_to admin_identities_path
  end
 
  def create
    identity.save
    redirect_to admin_identities_path
  end
end

