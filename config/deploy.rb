# config valid only for Capistrano 3.1
lock '3.7.2'

set :application, 'dogstribuidora'
set :repo_url, 'git@github.com:matiasrenta/dog.git'

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

set :bundle_flags, '--deployment'



