package :build_essential do

  apt %w(build-essential)

  verify do
    has_executable 'gcc'
  end

end
