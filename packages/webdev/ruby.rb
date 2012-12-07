# FIXME: rvm doesn't run

package :rvm_ruby_193 do

  runner 'source ~/.profile'
  runner 'rvm install 1.9.3'
  runner 'rvm --default use 1.9.3'
  runner 'rvm gemset create global'
  runner 'rvm gemset use global'
  gem %w(install rake bundler thor thin foreman capistrano capistrano-ext capistrano_colors pry pry-doc)

end
