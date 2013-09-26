package :create_user do

  deploy_user = Sprinkle::Settings.fetch(:target_user)
  deploy_group = Sprinkle::Settings.fetch(:target_group)

  runner "addgroup #{deploy_group} || true"
  runner "useradd -m #{deploy_user} || true"
  runner "adduser #{deploy_user} #{deploy_group} || true"
  runner "usermod -a -G #{deploy_group} #{deploy_user} || true"

  replace_text "%admin ALL=(ALL) ALL", "%admin ALL=(ALL) NOPASSWD: ALL", '/etc/sudoers', sudo: true

  # verify do
  #   has_user deploy_user
  #   has_group deploy_group
  #   has_user deploy_user, in_group: deploy_group
  # end

end

package :change_user_password do

  deploy_user = Sprinkle::Settings.fetch(:target_user)
  deploy_password = Sprinkle::Settings.fetch(:target_password)
  double_password = [ deploy_password, '\n', deploy_password ].join
  cmd = push_password_to_cmd(double_password, "sudo passwd #{deploy_user}")

  runner cmd

end

package :change_user_login_shell_to_bash do

  deploy_user = Sprinkle::Settings.fetch(:target_user)
  deploy_password = Sprinkle::Settings.fetch(:target_password)
  zsh_path = '/bin/bash'

  cmd = "sudo chsh -s #{zsh_path} #{deploy_user}"
  cmd = push_password_to_cmd(deploy_password, cmd)

  runner cmd

end

package :change_user_login_shell_to_zsh do

  deploy_user = Sprinkle::Settings.fetch(:target_user)
  deploy_password = Sprinkle::Settings.fetch(:target_password)
  zsh_path = '/usr/bin/zsh'

  cmd = "sudo chsh -s #{zsh_path} #{deploy_user}"
  cmd = push_password_to_cmd(deploy_password, cmd)

  runner cmd

end

package :zsh_config_reset do
  deploy_user = Sprinkle::Settings.fetch(:target_user)
  cmd = "touch /home/#{deploy_user}/.zshrc"
  runner cmd
end
