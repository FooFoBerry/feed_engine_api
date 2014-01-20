require "rvm/capistrano"
require "bundler/capistrano"

set :deploy_to, "/var/www/foofoberry/api"
set :repository,  "git://github.com/foofoberry/feed_engine_api.git"
set :rvm_ruby_string, "2.0.0@api"
set :use_sudo, false
set :deploy_via, :remote_cache

set :user, "app"
role :web, "162.243.206.48"
role :app, "162.243.206.48"
role :db,  "162.243.206.48", :primary => true

after "deploy:restart", "deploy:cleanup"
after "deploy", "rvm:trust_rvmrc"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end
