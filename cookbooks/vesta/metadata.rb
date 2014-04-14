name             'vesta'
maintainer       'Brint O\'Hearn'
maintainer_email 'brint.ohearn@rackspace.com'
license          'Apache 2.0'
description      'Installs Vesta control panel'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'
recipe           'vesta', 'Installs Vesta'
recipe           'vesta::firewall', 'Opens Vesta management port'

%w( firewall iptables-ng ).each do |cb|
  depends cb
end

%w( ubuntu debian centos rhel ).each do |os|
  supports os
end
