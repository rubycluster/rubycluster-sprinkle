require './config/helpers'
init(__FILE__)

policy :base_user, roles: :master do

  requires_each(%w[
    zsh_config_reset
    rvm_config
    rvm_rubies
    yadr
    change_user_login_shell_to_zsh
    tmuxinator
    dotfiles
  ])

end
