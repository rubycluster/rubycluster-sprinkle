set :hostingserver, CONFIG[:vagrant][:server]
set :port, CONFIG[:vagrant][:port]
set :user, CONFIG[:vagrant][:user]

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
