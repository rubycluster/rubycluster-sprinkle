package :dotfiles do

  requires_each(%w[
    rubygems
    tmux
    #tmuxinator
    #bash_rc
    #bash_aliases
    #zshrc
    #gitconfig
    #gitignore
    #vim
    #vimrc_local
    #ssh_config
    #rvmrc
    #irbrc
    #pryrc
    #!pinerc
  ].map{ |i| "dotfiles_#{i}" })

end
