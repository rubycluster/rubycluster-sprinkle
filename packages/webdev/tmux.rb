package :tmux do

  apt %w(libevent-dev libncurses5-dev)
  version '1.7'
  source "http://downloads.sourceforge.net/tmux/tmux-#{version}.tar.gz"

  verify do
    has_executable 'tmux'
  end

end

package :tmuxinator do

  gem 'tmuxinator'
  push_text '[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator', '~/.bashrc'

  verify do
    has_gem 'tmuxinator'
  end

end
