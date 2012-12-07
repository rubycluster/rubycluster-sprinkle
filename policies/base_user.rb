require './config/helpers'
init(__FILE__)

policy :base_user, roles: :master do

  requires_each(%w[
    rvm
    #rvm_ruby_193
    yadr
    dotfiles
  ])

end
