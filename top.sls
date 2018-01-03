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
    - extlinux
    - graphics
    - kiosk
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

  'role:tftp-server':
    - match: pillar
    - tftp
    - hosts
    - snmp

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

  'salt.magevent.net':
    - managed.master
    - cloud
    - saltpad
    - hosts
    - snmp

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

  'freeipa.magevent.net':
    - freeipa
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

  'ntp*.magevent.net':
    - ntp
    - hosts
    - managed
    - snmp

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

  'cups.magevent.net':
    - cups
    - hosts
    - managed
    - snmp

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

  'find.magevent.net':
    - firewall
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - find
    - snmp

  'stereo.magevent.net':
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts
    - snmp

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

  'zoneminder.magevent.net':
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

