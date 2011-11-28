
namespace :mysql do
  desc "Backup the remote production database"
  task :backup, :roles => :db, :only => {:primary => true} do
    filename = "#{application}.dump.#{Time.now.to_i}.sql.bz2"
    file = "/tmp/#{filename}"
    on_rollback { delete file }
    db = YAML::load(ERB.new(IO.read(File.join(File.dirname(__FILE__), '../database.yml'))).result)['production']
    run "mysqldump -u #{db['username']} --password=#{db['password']} #{db['database']} | bzip2 -c > #{file}" do |ch, stream, data|
      puts data
    end
    `mkdir -p #{File.dirname(__FILE__)}/../backups/`
    get file, "backups/#{filename}"
    `gpg -c #{File.dirname(__FILE__)}/../backups/#{filename}`
    `rm #{File.dirname(__FILE__)}/../backups/#{filename}`
    # delete file
  end

  task :download, :roles => :db, :only => {:primary => true} do
    filename = "#{application}.dump.sql"
    file = "/tmp/#{filename}"
    on_rollback { delete file }
    db = YAML::load(ERB.new(IO.read(File.join(File.dirname(__FILE__), '../database.yml'))).result)
    production = db['production']

    pass_ops = !production['password'].nil? ? "--password=#{production['password']}" : ''
    run "mysqldump -u #{production['username']} #{pass_ops} #{production['database']} > #{file}" do |ch, stream, data|
      puts data
    end
    get file, "tmp/#{filename}"
  end
end


