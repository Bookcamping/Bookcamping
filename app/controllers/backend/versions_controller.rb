class Backend::VersionsController < Backend::ResourceController
  protected

  def collection
    @versions = Version.limit(100).all
  end
end

