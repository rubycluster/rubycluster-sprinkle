package :git, :providews => :scm do

  apt 'git-core'

  verify do
    has_executable 'git'
  end

end
