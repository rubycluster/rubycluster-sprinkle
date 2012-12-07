package :no_apache do
  run "/etc/init.d/apache2 stop"
  run "apt-get remove apache2*"
end
