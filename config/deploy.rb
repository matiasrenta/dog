# config valid only for Capistrano 3.1
lock '3.7.2'

require 'seed-fu/capistrano3'

set :application, 'dogstribuidora'
set :repo_url, 'git@github.com:matiasrenta/dog.git'

# Default branch is :master
set :branch, :staging

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deployer/railsapps/dog_staging'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true


set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
#set :rbenv_map_bins, %w{rake gem bundle ruby rails}
#set :rbenv_roles, :all # default value


# para que bundle no interfiera con el directorio bin/ de esta forma se baja del github lo que haya en el bin (ademas lo quite del linked_dirs)
set :bundle_binstubs, nil

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml .env.production}

# Default value for linked_dirs is []
set :linked_dirs, %w{uploads log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

set :bundle_flags, '--deployment'

namespace :deploy do

  #before  'deploy:assets:precompile', 'deploy:migrate'

  #namespace :assets do
  #  Rake::Task['deploy:assets:precompile'].clear_actions
  #  desc 'Precompile assets locally and upload to servers'
  #  task :precompile do
  #    on roles(fetch(:assets_roles)) do
  #      run_locally do
  #        execute 'RAILS_ENV=production bundle exec rake assets:precompile'
  #        #with rails_env: fetch(:rails_env) do
  #        #  execute 'bin/rake assets:precompile'
  #        #end
  #      end
  #      within release_path do
  #        with rails_env: fetch(:rails_env) do
  #          old_manifest_path = "#{shared_path}/public/assets/manifest*"
  #          execute :rm, old_manifest_path if test "[ -f #{old_manifest_path} ]"

  #          #run "rm -rf #{shared_path}/public/assets"
  #          upload!('./public/assets/', "#{shared_path}/public/", recursive: true)
  #        end
  #      end
  #      run_locally { execute 'rm -rf public/assets' }
  #    end
  #  end
  #end

  desc 'Restart application by restarting puma service'
  task :restart do
    on roles(:app) do
      server_command = "/home/deployer/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/deployer/railsapps/dog_staging/shared/puma.rb phased-restart"
      app_current = '/home/deployer/railsapps/dog_staging/current'
      execute "cd '#{app_current}'; #{server_command}"
      #execute "sudo service puma-chucky-template restart"
    end
  end

  before 'deploy:publishing', 'db:seed_fu'

  after :publishing, :restart

  #after :restart, :clear_cache do
  #  on roles(:web), in: :groups, limit: 3, wait: 10 do
  #    # Here we can do anything such as:
  #    #within release_path do
  #    #  execute :rake, 'cache:clear'
  #    #end
  #  end
  #end

  after :finishing, 'deploy:cleanup'

end

