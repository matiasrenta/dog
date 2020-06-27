
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




