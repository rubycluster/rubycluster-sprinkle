require './config/helpers'
init(__FILE__)

policy :init_remote, roles: :master do

  requires_each(%w[
    init_vps
  ])

end
