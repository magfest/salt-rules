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
    - syslog

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
    - syslog

  'role:tftp-server':
    - match: pillar
    - tftp
    - hosts
    - snmp
    - zabbix
    - syslog

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
    - syslog

  'salt.magevent.net':
    - managed.master
    - cloud
    - saltpad
    - hosts
    - snmp
    - zabbix
    - syslog

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
    - syslog

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
    - syslog

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
    - syslog

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
    - syslog
    
    'freeradius2020.magevent.net':
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
    - syslog

  'cups.magevent.net':
    - cups
    - hosts
    - managed
    - snmp
    - zabbix
    - syslog

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
    - syslog

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
    - syslog

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
    - syslog

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
    - syslog

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
    - syslog

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

  'syslog.magevent.net':
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
    - syslog-server
    
  'netbox.magevent.net':
    - firewall
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp
    - zabbix
    - syslog-server
