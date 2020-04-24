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
set :branch, :staging

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deployer/railsapps/dog_staging'

# Default value for keep_releases is 5
set :keep_releases, 1

desc 'Restart application by restarting puma service'
task :restart do
  on roles(:app) do
    server_command = "/home/deployer/.rbenv/bin/rbenv exec bundle exec pumactl -F /home/deployer/railsapps/dog_staging/shared/puma.rb phased-restart"
    app_current = '/home/deployer/railsapps/dog_staging/current'
    execute "cd '#{app_current}'; #{server_command}"
    #execute "sudo service puma-dog restart"
  end
end


