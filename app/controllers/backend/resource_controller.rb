class Backend::ResourceController < Backend::ApplicationController
  respond_to :html, :json, :xml

  expose(:resource_class) { resource_name.camelcase.constantize }
  expose(:resource_attributes) { resource_class.attribute_names }
  expose(:resources) { send(resource_name.pluralize) }
  expose(:resource) { send(resource_name) } 
  expose(:page_param) { params[:page].present? ? params[:page] : 1 } 

  def create
    create!
  end

  def update
    update!
  end

  def create!(url = nil)
    url ||= [:backend, resource]
    flash[:notice] = t(".notice.created") if resource.save
    respond_with resource, location: url
  end

  def update!(url = nil)
    url ||= [:backend, resource]
    flash[:notice] = t(".notice.updated") if resource.save
    respond_with resource, location: url
  end 

  def self.expose_resource(name)
    define_method :resource_name do
      name.to_s
    end

    expose(name.to_s.pluralize.to_sym) { resource_class.order('id DESC').page(page_param) }
    expose(name.to_sym) 
  end
end

