class NotifyVersion
  @queue = :bookcamping

  def self.perform(version_id)
    version = Version.find version_id
    Activities.new(version).build 
  end
end

      
