## Change to match your CPU core count
#workers 1
#
## Min and Max threads per worker
#threads 1, 2
#
#app_dir = File.expand_path("../..", __FILE__)
#shared_dir = "#{app_dir}/shared"
#
## Default to production
#rails_env = "production" # ENV['RAILS_ENV'] || "production"
#environment rails_env
#
## Logging
#stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true
#
## Set master PID and state locations
#pidfile "#{shared_dir}/pids/puma.pid"
#state_path "#{shared_dir}/pids/puma.state"
#
#preload_app!
#
## Set up socket location
#bind "unix://#{shared_dir}/sockets/puma.sock"
#
#
##daemonize true
#
#activate_control_app
#
#on_worker_boot do
#  require "active_record"
#  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
#  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
#end


#!/usr/bin/env puma
directory '/home/deployer/railsapps/chucky-template/current'
rackup "/home/deployer/railsapps/chucky-template/current/config.ru"
environment 'production'

tag ''

pidfile "/home/deployer/railsapps/chucky-template/shared/tmp/pids/puma.pid"
state_path "/home/deployer/railsapps/chucky-template/shared/tmp/pids/puma.state"
stdout_redirect '/home/deployer/railsapps/chucky-template/shared/log/puma_access.log', '/home/deployer/railsapps/chucky-template/shared/log/puma_error.log', true

threads 0,16

bind 'unix:///home/deployer/railsapps/chucky-template/shared/tmp/sockets/puma.sock'

workers 1

restart_command 'bundle exec puma'

prune_bundler

on_restart do
  puts 'Refreshing Gemfile'
  ENV["BUNDLE_GEMFILE"] = "/home/deployer/railsapps/chucky-template/current/Gemfile"
end