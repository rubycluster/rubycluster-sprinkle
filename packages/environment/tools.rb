package :tools do

  apt %w(aptitude)
  apt %w(curl)
  apt %w(
    openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev
    libxml2-dev libxslt-dev autoconf libc6-dev
    ncurses-dev automake libtool bison libcurl4-openssl-dev
  )

  verify do
    has_executable "aptitude"
    has_executable "curl"
  end

  requires :sqlite3
  requires :svn

end
