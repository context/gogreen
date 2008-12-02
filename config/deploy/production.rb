set :deploy_to, "/home/#{user}/#{application}"
set :user, "radicaldesigns"

role :app,  "gogreen.dreamhosters.com"
role :web,  "gogreen.dreamhosters.com"
role :db,   "gogreen.dreamhosters.com", :primary => true

namespace :deploy do
  task :symlink_dbs, :roles => :app, :except => {:no_symlink => true} do
    invoke_command "ln -nfs #{shared_path}/db/development.sqlite3 #{release_path}/db/development.sqlite3"
  end
end

