require './config/helpers'
init(__FILE__)

policy :base_sudo, roles: :master do

  requires_each(%w[
    environment
    git
    rvm_dependencies
    mysql
    zsh
    vim
    tmux
    tmuxinator
    #nginx
    #passenger
  ])

end
