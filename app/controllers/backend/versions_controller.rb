class Backend::VersionsController < Backend::ResourceController
  expose_resource :version

  expose(:versions) { Version.order('id DESC').limit(50) }

  def index
    index!
  end
end

