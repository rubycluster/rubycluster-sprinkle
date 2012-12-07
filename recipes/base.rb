set :hostingserver, config(:server)
set :port, config(:target, :port)
set :port, config(:initial, :port) if fetch(:port).blank?
set :user, config(:target, :user)

set :target_port, config(:target, :port)
set :target_user, config(:target, :user)
set :target_password, config(:target, :password)
set :target_group, config(:target, :group)

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
