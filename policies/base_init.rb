require './config/helpers'
init(__FILE__)

policy :base_init, roles: :master do

  requires_each(%w[
    create_user
    change_user_password
    prepare_user_ssh_files
    copy_public_key
    config_ssh
    reload_ssh
  ])

  requires :restart_ssh if ssh_port_should_be_changed?

end
