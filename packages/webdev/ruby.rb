# FIXME: rvm doesn't run

package :rvm_rubies do
  # requires :rvm_ruby_193
end

package :rvm_ruby_193 do

  requires :rvm_load

  cmd = [
    'source /etc/profile.d/rvm.sh',
    'rvm install 1.9.3',
    'rvm --default use 1.9.3',
    'rvm gemset use global --create',
    'rvm rubygems latest',
  ].join ' ; '

  runner cmd

  # gem %w(rake bundler thor thin foreman capistrano capistrano-ext capistrano_colors pry pry-doc)

end
