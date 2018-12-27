base:
  'role:container':
    - match: pillar
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp
    - zabbix

  'role:laptop':
    - match: pillar
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - desktop
    - desktop.utilities
    - desktop.admins
    - desktop.wifi
    - graphics
    - selinux
    - laptop.notify
    - hosts
    - snmp
    - cups.client

  'role:dhcp-server':
    - match: pillar
    - dhcp
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp
    - zabbix

  'role:tftp-server':
    - match: pillar
    - tftp
    - hosts
    - snmp
    - zabbix

  'role:dns-server':
    - match: pillar
    - dns
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp
    - zabbix

  'salt.magevent.net':
    - managed.master
    - cloud
    - saltpad
    - hosts
    - snmp
    - zabbix

  'asterisk.magevent.net':
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - asterisk
    - snmp

  'repo.magevent.net':
    - mrepo
    - hosts
    - managed
    - snmp
    - zabbix

  'tftp.magevent.net':
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - tftp
    - voip-provision
    - ftp
    - hosts
    - snmp
    - zabbix

  'foreman.magevent.net':
    - firewall
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp

  'ntp*.magevent.net':
    - ntp
    - hosts
    - managed
    - snmp
    - zabbix

  'freeradius.magevent.net':
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - freeradius
    - hosts
    - snmp
    - zabbix

  'cups.magevent.net':
    - cups
    - hosts
    - managed
    - snmp
    - zabbix

  'noc.magevent.net':
    - match: pillar
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp

  'assman.magevent.net':
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp

  'smokeping.magevent.net':
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp
    - zabbix

  'radios.magevent.net':
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - radios
    - snmp
    - zabbix

  'badges.magevent.net':
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - swadges
    - snmp
    - zabbix

  'stereo.magevent.net':
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp
    - zabbix

  'index.magevent.net':
    - webserver
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp
    - zabbix

  'vpn.magevent.net':
    - index
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp


