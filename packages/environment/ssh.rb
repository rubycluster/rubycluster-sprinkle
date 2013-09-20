package :openssh do

  apt 'openssh-server'

  verify do
    has_apt 'openssh-server'
    has_executable 'ssh'
  end

end

package :reload_ssh do

  noop do
    post :install, "service ssh reload; exit"
  end

end

package :restart_ssh do

  noop do
    post :install, "service ssh restart; exit"
  end

end

package :config_ssh do

  file_path = '/etc/ssh/sshd_config'

  replace_text "#PasswordAuthentication yes", "PasswordAuthentication no", file_path, sudo: true

  requires :openssh
  requires :change_ssh_port if ssh_port_should_be_changed?

  verify do
    file_contains file_path, "PasswordAuthentication no"
  end

end

package :change_ssh_port do

  deploy_port = Sprinkle::Settings.fetch(:target_port)
  file_path = '/etc/ssh/sshd_config'

  replace_text "Port 22", "Port #{deploy_port}", file_path, sudo: true

  verify do
    file_contains file_path, "Port #{deploy_port}"
  end

end

package :prepare_user_ssh_files do

  deploy_user = Sprinkle::Settings.fetch(:target_user)

  runner "mkdir -p /home/#{deploy_user}/.ssh"
  # runner "touch /home/#{deploy_user}/.ssh/id_rsa"
  # runner "touch /home/#{deploy_user}/.ssh/id_rsa.pub"
  runner "touch /home/#{deploy_user}/.ssh/authorized_keys"
  runner "chown -R #{deploy_user}:#{deploy_user} /home/#{deploy_user}/.ssh/"
  runner "chmod 0600 /home/#{deploy_user}/.ssh/id_rsa"

  verify do
    has_file "/home/#{deploy_user}/.ssh/id_rsa.pub"
    has_file "/home/#{deploy_user}/.ssh/authorized_keys"
  end

end

package :copy_public_key do

  deploy_user = Sprinkle::Settings.fetch(:target_user)
  local_public_key_path = File.join(ENV["HOME"], ".ssh", "id_rsa.pub")

  if File.exists?(local_public_key_path)

    config_file = "/home/#{deploy_user}/.ssh/authorized_keys"
    config_text = File.open(local_public_key_path).read.lstrip

    push_text config_text, config_file, :sudo => true

    verify do
      has_file config_file
      file_contains config_file, config_text.slice(0,100)
    end

  else
    puts "no public key at: #{local_public_key_path} so adding keys is unavailable"
  end

end
