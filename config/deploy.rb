require "bundler/capistrano"
set :bundle_flags, "--deployment --quiet --binstubs"
set :domain, "109.107.37.177"
set :utility, "109.107.37.109"
set :application, "sinatra_hello"
set :deploy_to, "/home/rails/app"
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"


set :user, "rails"
set :use_sudo, false
set :group, user
set :runner, user
set :rails_env, "staging"

set :default_environment, {
  'PATH' => "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH"
}

set :scm, :git
set :repository,  "git@github.com:mcansky/sinatra_hello.git"
set :branch, 'master'
set :git_shallow_clone, 1

set :host, "#{user}@109.107.37.177"

role :web, domain
role :app, domain
role :util, utility
#role :db,  domain, :primary => true

set :deploy_via, :remote_cache

# Unicorn control tasks
namespace :deploy do
  task :setup_config, roles: [:app, :util] do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/pids"
    run "mkdir -p #{shared_path}/logs"
    run "mkdir -p #{shared_path}/sockets"
    run "mkdir -p #{deploy_to}/releases"
  end

  task :symlink_config_db, roles: [:app, :util] do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  task :symlink_config_web, roles: :app do
    run "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
  end

  task :restart, roles: :app do
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start, roles: :app do
    run "cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop, roles: :app do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
  after "deploy:restart", "deploy:symlink_config_web", "deploy:symlink_config_db"
end
