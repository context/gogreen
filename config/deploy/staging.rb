set :deploy_to, "/home/#{user}/#{application}"

role :app,  "gogreen.staging.radicaldesigns.org"
role :web,  "gogreen.staging.radicaldesigns.org"
role :db,   "gogreen.staging.radicaldesigns.org", :primary => true

namespace :deploy do
  task :symlink_dbs, :roles => :app, :except => {:no_symlink => true} do
    invoke_command "ln -nfs #{shared_path}/db/development.sqlite3 #{release_path}/db/development.sqlite3"
  end
end

