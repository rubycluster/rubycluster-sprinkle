package :init_vps do

  requires :init_users
  requires :init_user_password
  requires :init_ssh
  requires :create_ssh_dirs
  requires :copy_public_key

end

package :init_users do

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

package :init_user_password do

  deploy_user = Package.fetch(:target_user)
  deploy_password = Package.fetch(:target_password)
  cmd = [
    'echo "', deploy_password, '\n', deploy_password, '"',
    ' | ', 'sudo passwd', deploy_user
  ].join

  noop do
    post :pre, cmd
  end

end

package :init_ssh do

  deploy_port = Package.fetch(:target_port)
  file_path = '/etc/ssh/sshd_config'

  replace_text "Port 22", "Port #{deploy_port}", file_path, sudo: true
  replace_text "#PasswordAuthentication yes", "PasswordAuthentication no", file_path, sudo: true
  noop do
    post :install, "service ssh restart; exit"
  end

  requires :openssh

  verify do
    file_contains file_path, "Port #{deploy_port}"
    file_contains file_path, "PasswordAuthentication no"
  end

end

package :create_ssh_dirs do

  deploy_user = Package.fetch(:target_user)

  noop do
    post :install, "mkdir -p /home/#{deploy_user}/.ssh"
    post :install, "touch /home/#{deploy_user}/.ssh/id_rsa"
    post :install, "touch /home/#{deploy_user}/.ssh/id_rsa.pub"
    post :install, "touch /home/#{deploy_user}/.ssh/authorized_keys"
    post :install, "chown -R #{deploy_user}:#{deploy_user} /home/#{deploy_user}/.ssh/"
    post :install, "chmod 0600 /home/#{deploy_user}/.ssh/id_rsa"
  end

  verify do
    has_file "/home/#{deploy_user}/.ssh/id_rsa.pub"
    has_file "/home/#{deploy_user}/.ssh/authorized_keys"
  end

end

package :copy_public_key do

  deploy_user = Package.fetch(:target_user)
  local_public_key_path = File.join(ENV["HOME"], ".ssh", "id_rsa.pub")

  if File.exists?(local_public_key_path)

    config_file = "/home/#{deploy_user}/.ssh/authorized_keys"
    config_text = File.open(local_public_key_path).read.lstrip

    push_text config_text, config_file, :sudo => false

    verify do
      has_file config_file
      file_contains config_file, config_text.slice(0,100)
    end

  else
    puts "no public key at: #{local_public_key_path} so adding keys is unavailable"
  end

end

package :openssh do

  apt 'openssh-server'

  verify do
    has_apt 'openssh-server'
    has_executable 'ssh'
  end

end
