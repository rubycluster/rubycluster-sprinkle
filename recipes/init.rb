set :deploy_sudo, true
relative_eval_from(__FILE__, %w[base.rb])

set :port, config(:initial, :port)
set :user, config(:initial, :user)
set :password, config(:initial, :password)

forward_variables
