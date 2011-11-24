class Activities
  class << self
    include Rails.application.routes.url_helpers
    include ActionDispatch::Routing::UrlFor


    # hay que tener en cuenta que muchas versiones no tiene autora pero se puede deducir
    def build(version)
      activity = nil
      default_url_options[:host] = Site.host
      
      if valid?(version)
        user = User.find version.whodunnit
        activity = Activity.create do |a|
          a.user = user
          a.user_name = user.name
          a.user_url = url_for(user)
          a.resource = find_resource(version)
          a.action = version.event
          a.title = build_title(a)
          a.url = build_url(version)
        end
        
        # add activity to owner
        # add activity to subscriptors
      end
      version.update_attribute(:processed, true)
      activity
    end

    def valid?(version)
      version.whodunnit.present? && version.item_type.present?
    end

    protected
    def find_resource(version)
      klazz = version.item_type.constantize
      klazz.send(:find, version.item_id)
    end

    def build_title(activity)
      "#{human_action(activity.action)} #{human_resource(activity.resource)} '#{activity.resource.title}'"
    end

    def build_url(version)
    end

    def human_action(action)
      case action.to_s
      when 'create'
       'creado'
      when 'update'
       'modificado'
      when 'destroy'
       'borrado'
      else
       action
      end 
    end

    def human_resource(resource)
      case resource.class.to_s
      when 'Book'
        'la referencia'
      else
        resource.class.to_s
      end
    end
  end
end
