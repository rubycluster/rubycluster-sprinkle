package :zsh do

  apt %w(zsh)

  verify do
    has_executable 'zsh'
  end

end
