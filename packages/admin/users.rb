package :create_user do

  deploy_user = Package.fetch(:target_user)
  deploy_group = Package.fetch(:target_group)

  # group deploy_group
  noop do
    post :install, "addgroup #{deploy_group} || true"
  end

  # user deploy_user do
  #   pre :install, "useradd #{deploy_user}"
  #   post :install, "usermod -a -G #{deploy_group} #{deploy_user}"
  # end
  noop do
    post :install, "useradd -m #{deploy_user} || true"
    post :install, "adduser #{deploy_user} #{deploy_group} || true"
    post :install, "usermod -a -G #{deploy_group} #{deploy_user} || true"
  end

  replace_text "%admin ALL=(ALL) ALL", "%admin ALL=(ALL) NOPASSWD: ALL", '/etc/sudoers', sudo: true

  # verify do
  #   has_user deploy_user
  #   has_group deploy_group
  #   has_user deploy_user, in_group: deploy_group
  # end

end

package :change_user_password do

  deploy_user = Package.fetch(:target_user)
  deploy_password = Package.fetch(:target_password)
  double_password = [ deploy_password, '\n', deploy_password ].join
  cmd = push_password_to_cmd(double_password, "sudo passwd #{deploy_user}"),

  noop do
    post :install, cmd
  end

end

package :change_user_login_shell_to_zsh do

  deploy_user = Package.fetch(:target_user)
  deploy_password = Package.fetch(:target_password)
  zsh_path = '/usr/bin/zsh'

  cmd = "chsh -s #{zsh_path} #{deploy_user}"
  cmd = push_password_to_cmd(deploy_password, cmd)

  noop do
    post :install, cmd
  end

end
