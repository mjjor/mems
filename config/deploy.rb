#require 'bundler/capistrano'

set :application, "mems "
set :repository,  "git@github.com:mjjor/mems.git"
set :deploy_to, "/var/www/mems"
set :scm, :git
set :branch, "master"
set :user, "railsadm"
set :scm_passphrase, "jym08!$MJJ"
set :group, "deployers"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, { :forward_agent => true, :port => 4321 }
set :keep_releases, 5
default_run_options[:pty] = true
server "192.168.0.206", :app, :web, :db, :primary => true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
