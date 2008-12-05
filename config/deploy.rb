require 'capistrano/ext/multistage'

set :user, "gogreen"
set :application, "gogreen"
set :repository,  "git@github.com:radicaldesigns/gogreen.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{user}/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

after "deploy:update_code", "deploy:symlink_shared"
after "deploy:update_code", "deploy:symlink_dbs"

namespace :deploy do
  task :start, :roles => :app do
  end

  task :stop, :roles => :app do
  end

  task :restart, :roles => :app do
    invoke_command "touch #{current_path}/tmp/restart.txt"
  end

  task :symlink_shared, :roles => :app, :except => {:no_symlink => true} do
    invoke_command "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    invoke_command "ln -nfs #{shared_path}/config/gogreen.yml #{release_path}/config/gogreen.yml"
    invoke_command "ln -nfs #{shared_path}/config/session_secret.txt #{release_path}/config/session_secret.txt"
    invoke_command "ln -nfs #{shared_path}/config/initializers/site_keys.rb #{release_path}/config/initializers/site_keys.rb"
    invoke_command "ln -nfs #{shared_path}/config/initializers/hoptoad.rb #{release_path}/config/initializers/hoptoad.rb"
    invoke_command "ln -nfs #{shared_path}/contests #{release_path}/public/contests"
  end
end
