
class Activity
  def self.for_user(user, page)
    versions = Version.where(whodunnit: user.id)
    prepare(versions, page)
  end

  protected
  def self.prepare(versions, page)
    versions.order('id DESC').limit(10)
  end
end

