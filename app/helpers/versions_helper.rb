module VersionsHelper
  def render_versions(collection)
    render partial: 'versions/version', collection: collection
  end
end

