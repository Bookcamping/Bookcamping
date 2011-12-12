module Extensions
  module ExposeResource
    extend ActiveSupport::Concern

    module ClassMethods
      def expose_resource(name)
        expose(:resource_class) { resource_name.camelcase.constantize }
        expose(:resource_attributes) { resource_class.attribute_names }
        expose(:resources) { send(resource_name.pluralize) }
        expose(:resource) { send(resource_name) } 
        expose(:page_param) { params[:page].present? ? params[:page] : 1 } 

        define_method :resource_name do
          name.to_s
        end

        expose(name.to_s.pluralize.to_sym) { resource_class.order('id DESC').page(page_param) }
        expose(name.to_sym) 

        define_method :index! do
          authorize! :read, resource_class
        end

        define_method :show! do
          authorize! :read, resource
          respond_with resource
        end 

        define_method :edit! do
          authorize! :edit, resource
          respond_with resource
        end

        define_method :create! do |url|
          url ||= [:backend, resource]
          flash[:notice] = t(".notice.created") if resource.save
          respond_with resource, location: url
        end

        define_method :update! do |url|
          url ||= [:backend, resource]
          flash[:notice] = t(".notice.updated") if resource.save
          respond_with resource, location: url
        end

        define_method :search! do 
        end
      end
    end
  end
end

