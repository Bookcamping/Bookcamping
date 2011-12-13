module VersionsHelper
  def render_versions(collection)
    render partial: 'shared/versions/version', 
      collection: versions 
  end
end

