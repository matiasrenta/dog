# production
#deploy_to = '/home/deployer/railsapps/dog'
#keep_releases = 2
#server_command = "/home/deployer/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/deployer/railsapps/dog/shared/puma.rb phased-restart"
#app_current = '/home/deployer/railsapps/dog/current'
#branch = :master

#staging
deploy_to = '/home/deployer/railsapps/dog_staging'
keep_releases = 2
server_command = "/home/deployer/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/deployer/railsapps/dog_staging/shared/puma.rb phased-restart"
app_current = '/home/deployer/railsapps/dog_staging/current'
branch = :staging

# Default branch is :master
set :branch, branch

# Default deploy_to directory is /var/www/my_app
set :deploy_to, deploy_to

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true


# Default value for keep_releases is 5
set :keep_releases, keep_releases

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
      execute "cd '#{app_current}'; #{server_command}"
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




=begin

# production

deploy_to = '/home/deployer/railsapps/dog'
keep_releases = 2
server_command = "/home/deployer/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/deployer/railsapps/dog/shared/puma.rb phased-restart"
app_current = '/home/deployer/railsapps/dog/current'


#staging
#deploy_to = '/home/deployer/railsapps/dog_staging'
#keep_releases = 2
#server_command = "/home/deployer/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/deployer/railsapps/dog_staging/shared/puma.rb phased-restart"
#app_current = '/home/deployer/railsapps/dog_staging/current'




# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
role :app,  %w{deployer@138.197.74.226}
role :web,  %w{deployer@138.197.74.226}
role :db,   %w{deployer@138.197.74.226}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '138.197.74.226', user: 'deployer', roles: %w{web app}, my_property: :my_value


# Default branch is :master
#ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, deploy_to

# Default value for keep_releases is 5
set :keep_releases, keep_releases

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

desc 'Restart application by restarting puma service'
task :restart do
  on roles(:app) do
    execute "cd '#{app_current}'; #{server_command}"
    #execute "sudo service puma-dog restart"
  end
end


=end

