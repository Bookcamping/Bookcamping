# SOURCES setup users: http://www.viget.com/extend/building-an-environment-from-scratch-with-capistrano-2/
# setup deploy: http://www.capify.org/getting-started/from-the-beginning/

# Standard deploy assets tasks
load 'deploy/assets' unless ENV.has_key?('skip-assets') and ENV['skip-assets'] == 'true'
require "bundler/capistrano"

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

role :app, "recortable.net"
role :web, "recortable.net"
role :db,  "recortable.net", :primary => true


# Add RVM's lib directory to the load path.
#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.2@rails31'
set :rvm_type, :user  # Don't use system-wide RVM


after "deploy", "deploy:cleanup"

load 'config/deploy/symlink'
#load 'conifg/deploy/passenger'
load 'config/deploy/mysql'
load 'config/deploy/unicorn'
load 'config/deploy/local_assets'
load 'config/deploy/archive'


