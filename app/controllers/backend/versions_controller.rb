class Backend::VersionsController < Backend::ResourceController
  protected

  def collection
    @versions = current_camp.versions.limit(100).order('id DESC').all
  end
end

