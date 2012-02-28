# encoding: utf-8
# Activities
# Un gestor de actividades. Su principal misión es convertir una versión en una actividad.
# 
class Activities
  class << self
    include Rails.application.routes.url_helpers
    include ActionDispatch::Routing::UrlFor

    def generate(limit)
      versions = Version.where(processed: false).order('id DESC').limit(limit)
      versions.each do |v|
        build(v)
      end
    end


    # Construye una actividad a partir de una versión
    # hay que tener en cuenta que muchas versiones no tiene autora pero se puede deducir
    def build(version)
      activity = nil
      default_url_options[:host] = Site.host

      if valid?(version)
        activity = Activity.new do |a|
          a.version_id = version.id
          a.resource = find_resource(version)
          a.user = find_user(version, a.resource)
          if a.user
            a.user_name = user.name
            a.user_url = url_for(user)
          else
            a.user_name = 'Anónimo'
            a.user_url = nil
          end
          a.action = version.event
          a.title = build_title(a)
          a.url = build_url(version)
          a.activity_at = version.created_at
        end
        unless activity.save
          puts activity.errors.inspect
          raise Exception.new(activity.errors.inspect)
        end

        # add activity to owner
        # add activity to subscriptors
      end
      version.update_attribute(:processed, true)
      activity
    end

    def find_user(version, resource)
      user_id = version.whodunnit || resource.user_id
      user_id ? User.find(user_id) : nil
    end

    def valid?(version)
      version.item_type.present?
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
      path = "#{version.item_type.underscore}_path"
      send(path, version.item_id, id: true)
    end

    def human_action(action)
      case action.to_s
      when 'create'
        'añadido'
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
      when 'Reference'
        'la referencia'
      else
        resource.class.to_s
      end
    end
  end
end
