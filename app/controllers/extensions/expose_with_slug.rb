module Extensions
  module ExposeWithSlug
    extend ActiveSupport::Concern

    module ClassMethods

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
  end
end

