set :hostingserver, CONFIG[:vps][:server]
set :port, CONFIG[:vps][:initial][:port]
# set :port, CONFIG[:vps][:target][:port]
set :user, CONFIG[:vps][:initial][:user]
set :password, CONFIG[:vps][:initial][:password]

set :target_port, CONFIG[:vps][:target][:port]
set :target_user, CONFIG[:vps][:target][:user]
set :target_password, CONFIG[:vps][:target][:password]
set :target_group, CONFIG[:vps][:target][:group]

set :runner, fetch(:user)

set :run_method, :sudo
set :use_sudo, true

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :master, fetch(:hostingserver)

forward_variables
