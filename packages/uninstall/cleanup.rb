package :cleanup do
  description "Cleanup"
  requires :apt_clean
  # recommends :reboot
end

package :apt_clean do
  runner 'apt-get clean'
end

package :reboot do
  runner 'reboot'
end
