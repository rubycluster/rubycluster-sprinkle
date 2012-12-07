package :rvm do

  runner '\curl -L https://get.rvm.io | bash -s stable'
  push_text '[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm', '~/.profile'

  verify do
    has_directory '~/.rvm'
    # has_executable 'rvm'
  end

end

package :rvm_dependencies do

  apt %w(ruby-dev rake)

end
