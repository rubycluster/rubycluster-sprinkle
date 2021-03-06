package :mysql, :provides => :database do

  apt %w(mysql-server mysql-client)

  verify do
    has_apt 'mysql-server'
    has_executable 'mysqld'
    has_executable 'mysql'
  end

  requires :mysql_dependencies

end

package :mysql_dependencies do

  apt %w(
    mysql-common
    ruby-mysql
    libmysqlclient15-dev
    libdbd-mysql-perl
    libdbi-perl
    libhtml-template-perl
    libnet-daemon-perl
    libplrpc-perl
    libreadline5
    libc6
    libpcre3
    libpcre3-dev
    libpcrecpp0
    libssl0.9.8
    libpq-dev
    psmisc
  )

end
