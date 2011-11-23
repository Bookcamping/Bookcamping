# SOURCES setup users: http://www.viget.com/extend/building-an-environment-from-scratch-with-capistrano-2/
# setup deploy: http://www.capify.org/getting-started/from-the-beginning/

# Standard deploy assets tasks
load 'deploy/assets'

# default_run_options[:pty] = true
set :application, "Bookcamping"
set :deploy_to, "/home/deploy/#{application}"
set :user, "deploy"
set :use_sudo, false

set :scm, "git"
set :repository,  "git://github.com/Bookcamping/Bookcamping.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :scm_verbose, false


role :clientapp, "recortable.net"
role :web, "recortable.net"
role :db,  "recortable.net", :primary => true


# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.2@rails31'
set :rvm_type, :user  # Don't use system-wide RVM


after "deploy:update_code", "config:copy_shared_configurations"
after "deploy", "deploy:cleanup"

# Configuration Tasks
namespace :config do
  desc "copy shared configurations to current"
  task :copy_shared_configurations, :roles => [:clientapp] do
    %w[database.yml amazon_s3.yml].each do |f|
      run "ln -nsf #{shared_path}/config/#{f} #{release_path}/config/#{f}"
    end
  end
end


namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :clientapp, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :clientapp do ; end
  end
end

# Assets management (deprecated)
namespace :myassets do
  task :precompile, :roles => :web do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake assets:precompile"
  end

  task :cleanup, :roles => :web do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake assets:clean"
  end
end

#after :deploy, "assets:precompile"


namespace :mysql do
  desc "Backup the remote production database"
  task :backup, :roles => :db, :only => { :primary => true } do
    filename = "#{application}.dump.#{Time.now.to_i}.sql.bz2"
    file = "/tmp/#{filename}"
    on_rollback { delete file }
    db = YAML::load(ERB.new(IO.read(File.join(File.dirname(__FILE__), 'database.yml'))).result)['production']
    run "mysqldump -u #{db['username']} --password=#{db['password']} #{db['database']} | bzip2 -c > #{file}"  do |ch, stream, data|
      puts data
    end
    `mkdir -p #{File.dirname(__FILE__)}/../backups/`
    get file, "backups/#{filename}"
  end

  task :download, :roles => :db, :only => { :primary => true } do
    filename = "#{application}.dump.sql"
    file = "/tmp/#{filename}"
    on_rollback { delete file }
    db = YAML::load(ERB.new(IO.read(File.join(File.dirname(__FILE__), 'database.yml'))).result)
    production = db['production']

    pass_ops = !production['password'].nil? ? "--password=#{production['password']}" : ''
    run "mysqldump -u #{production['username']} #{pass_ops} #{production['database']} > #{file}"  do |ch, stream, data|
      puts data
    end
    get file, "tmp/#{filename}"
    #`mysql -u root -p booka < tmp/#{filename}`
    # delete file
  end
end

# http://fernando.blat.es/post/12563486374/optimize-deploy-time-compiling-your-assets-locally
namespace :assets do
  desc "Precompile assets in a local file"
  task :precompile_local do
    run_locally 'rm -rf /public/assets/*'
    with_env 'RAILS_ENV', 'production' do
      run_locally 'bundle exec rake assets:precompile'
    end
    run_locally "touch assets.tgz && rm assets.tgz"
    run_locally "tar zcvf assets.tgz public/assets/"
    run_locally "mv assets.tgz tmp/"
  end

  desc "Upload package and deploy"
  task :package_deploy do
    upload 'tmp/assets.tgz', "#{release_path}/assets.tgz"
    run "cd #{release_path}; tar zxvf assets.tgz; rm assets.tgz"
  end
end

#before :deploy, 'assets:precompile_local'
#after 'deploy:finalize_update', 'assets:package_deploy'

# https://gist.github.com/238268
# http://stackoverflow.com/questions/1732415/how-to-deploy-resque-workers-in-production
namespace :god do
  desc "Starts god by loading the config path"
  task :start do
    run "god -c #{release_path}/config/god/app.god"
    run "#{try_sudo} god start resque"
  end
  
  desc "Stops god by running quit"
  task :quit do
    run "god quit"
  end
end
