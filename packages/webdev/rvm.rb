package :rvm do

  deploy_user = Package.fetch(:target_user)

  noop do
    post :install, '\curl -L https://get.rvm.io | sudo bash -s stable'
    # post :install, 'source /etc/profile.d/rvm.sh'
    post :install, "adduser #{deploy_user} rvm"
  end
  # push_text '[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm', '~/.bashrc'

  requires :rvm_dependencies

  verify do
    has_directory '/usr/local/rvm'
    has_file '/usr/local/rvm/bin/rvm'
  end

end

package :rvm_dependencies do

  apt %w(ruby-dev rake)

end
