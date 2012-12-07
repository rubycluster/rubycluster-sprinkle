package :svn, :providews => :scm do

  apt 'subversion'

  verify do
    has_executable 'svn'
  end

end
