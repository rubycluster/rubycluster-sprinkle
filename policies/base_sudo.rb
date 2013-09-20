require './config/helpers'
init(__FILE__)

policy :base_sudo, roles: :master do

  requires_each(%w[
    environment
    git
    rvm
    mysql
    zsh
    vim
    tmux
    #no_apache
    #nginx
    #passenger
    imagemagick
    cleanup
  ])

end
