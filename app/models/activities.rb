class Activities
  def initialize(version)
    @version = version
    ActivityMailer.activity_email(version).deliver
    version.update_attribute(:processed, true)
  end

  def build
# add activity to owner
# add activity to subscriptors
  end
end

