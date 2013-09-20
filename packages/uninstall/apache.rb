package :no_apache do
  runner "/etc/init.d/apache2 stop"
  runner "apt-get remove apache2*"
end
