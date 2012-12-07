set :hostingserver, CONFIG[:vps][:server]
set :port, CONFIG[:vps][:target][:port]
set :user, CONFIG[:vps][:target][:user]
set :target_password, CONFIG[:vps][:target][:password]

set :runner, fetch(:user)

if fetch(:deploy_sudo).nil?
  set :deploy_sudo, ENV['DEPLOY_SUDO'] == 'true'
end

if fetch(:deploy_sudo)
  set :run_method, :sudo
  set :use_sudo, true
else
  set :run_method, :run
  set :use_sudo, false
end

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :master, fetch(:hostingserver)

forward_variables
