module ExposeResource
  extend ActiveSupport::Concern

  module ClassMethods
    def delegate_resource(name, options)
      original = name.to_s
      delegated = options[:to].to_s

      expose(original.to_sym) { send(delegated) }
      expose(original.pluralize.to_sym) { send(original.pluralize) }
    end


    def expose_resource(name, options = {})
      options.reverse_merge!(as: name)
      exposed_name = options[:as].to_s

      define_method :resource_name do
        name.to_s
      end

      expose(:resource_class) { resource_name.camelcase.constantize }
      expose(:resource_attributes) { resource_class.attribute_names }
      expose(:resources) { send(exposed_name.pluralize) }
      expose(:resource) { send(exposed_name) }
      expose(:page_param) { params[:page] || 1 }


      expose(exposed_name.pluralize.to_sym) { resource_class.order('id DESC').page(page_param) }
      expose(exposed_name.to_sym)

      define_method :index! do
        authorize! :index, resource_class
      end

      define_method :show! do
        authorize! :read, resource
        respond_with resource
      end

      define_method :new! do
        authorize! :create, resource
        respond_with resource
      end

      define_method :edit! do
        authorize! :update, resource
        respond_with resource
      end

      # TODO: url should be optional
      define_method :create! do |url = nil|
        authorize! :create, resource
        flash[:notice] = t(".resource.created") if resource.save
        respond_with resource, location: url
      end

      define_method :update! do |url = nil|
        authorize! :update, resource
        flash[:notice] = t(".resource.updated") if resource.save
        respond_with resource, location: url
      end

      define_method :destroy! do |url = nil|
        authorize! :update, resource
        flash[:notice] = t(".resource.updated") if resource.destroy
        respond_with resource, location: url
      end

      define_method :search! do
      end
    end
  end
end

