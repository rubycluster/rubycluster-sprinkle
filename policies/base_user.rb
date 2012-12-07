require './config/helpers'
init(__FILE__)

policy :base_user, roles: :master do

  requires_each(%w[
    #rvm_ruby_193
    yadr
    change_user_login_shell_to_zsh
    dotfiles
  ])

end
