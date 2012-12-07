package :yadr do

  deploy_password = Package.fetch(:target_password)

  runner 'git clone https://github.com/skwp/dotfiles ~/.yadr'
  cmd = [
    "cd ~/.yadr && ",
    push_password_to_cmd(deploy_password, 'rake install')
  ].join

  noop do
    post :install, cmd
  end

  verify do
    has_directory '~/.yadr'
  end

end
