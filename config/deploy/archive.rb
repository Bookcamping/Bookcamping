
namespace :archive do
  desc "Update the archive repository"
  task :update do
    run "cd #{shared_path}/system/archive; git pull origin master"
  end
end


