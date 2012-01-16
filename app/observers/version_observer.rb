class VersionObserver < ActiveRecord::Observer
  observe :version

  def after_create(version)
#    Resque.enqueue(NotifyVersion, version.id)
  end
end
