package :rvm do

  deploy_user = Sprinkle::Settings.fetch(:target_user)

  runner '\curl -L https://get.rvm.io | sudo bash -s stable'
  # runner 'source /etc/profile.d/rvm.sh'
  runner "adduser #{deploy_user} rvm"
  # push_text '[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm', '~/.bashrc'

  requires :rvm_dependencies

  verify do
    has_directory '/usr/local/rvm'
    has_file '/usr/local/rvm/bin/rvm'
  end

end

package :rvm_config do

  path = "/etc/profile.d/rvm.sh"
  text = "[[ -s #{path} ]] && source #{path}"
  bashrc = '~/.bashrc'
  zshrc = '~/.zshrc'

  push_text text, bashrc
  push_text text, zshrc

  verify do
    has_file bashrc
    file_contains bashrc, text
    has_file zshrc
    file_contains zshrc, text
  end

end

package :rvm_dependencies do

  apt %w(ruby-dev rake)

end

package :rvm_load do

  runner '. /etc/profile.d/rvm.sh'

end
