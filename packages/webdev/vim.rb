package :vim do

  apt %w(vim)

  verify do
    has_executable 'vim'
  end

end
