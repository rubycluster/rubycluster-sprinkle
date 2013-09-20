package :tmux do

  apt %w(tmux)

  verify do
    has_executable 'tmux'
  end

end

package :tmuxinator do

  gem 'tmuxinator'
  push_text 'source ~/.bin/tmuxinator.bash', '~/.bashrc'

  verify do
    has_gem 'tmuxinator'
  end

  requires :tmux

end
