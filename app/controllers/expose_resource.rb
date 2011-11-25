module ExposeResource

  def self.included(base)
    base.extend(ClassMethods)
  end

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
    end

    def expose_with_slug
      default_exposure do |name|
        collection = name.to_s.pluralize
        if respond_to?(collection) && collection != name.to_s && send(collection).respond_to?(:scoped)
          proxy = send(collection)
        else
          proxy = name.to_s.classify.constantize
        end

        if params.has_key?(:id)
          shelf = proxy.find_by_slug(params[:id])
          shelf ||= proxy.find(params[:id])
          shelf.tap do |r|
            r.attributes = params[name] unless request.get?
          end
        else
          proxy.new(params[name])
        end
      end
    end
  end
  
 def create
    create!
  end

  def update
    update!
  end

  def search
    search!
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

  def search!
   @search = {}
     
    @search[:column] = params[:column].present? ? params[:column] : 'id'
    @search[:value] = params[:value].present? ? params[:value] : '-1'
    condition = "#{@search[:column]} = ?"
    @search[:results] = resource_class.where([condition, @search[:value]]).order('id DESC').page(page_param)
  end
end

