require './config/helpers'
init(__FILE__)

policy :base_init, roles: :master do

  requires_each(%w[
    create_user
    change_user_password
    #change_user_login_shell_to_bash
    prepare_user_ssh_files
    copy_public_key
    config_ssh
    reload_ssh
  ])

  requires :restart_ssh if ssh_port_should_be_changed?

end
