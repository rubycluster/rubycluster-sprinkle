package :yadr do

  deploy_password = Package.fetch(:target_password)
  answer_password = "echo '#{deploy_password}'"

  runner 'git clone https://github.com/skwp/dotfiles ~/.yadr'
  runner "cd ~/.yadr && #{answer_password} | rake install"

  verify do
    has_directory '~/.yadr'
  end

end
