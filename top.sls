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
    - extlinux
    - graphics
    - kiosk
    - challenges
    - selinux
    - challenges.emulators
    - laptop.notify
    - hosts

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

  'role:tftp-server':
    - match: pillar
    - tftp
    - hosts

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

  'salt.magevent.net':
    - managed.master
    - cloud
    - saltpad
    - hosts

  'asterisk.magevent.net':
    - asterisk
    - managed

  'repo.magevent.net':
    - mrepo
    - hosts
    - managed

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

  'foreman.magevent.net':
    - firewall
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts

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

  'ntp*.magevent.net':
    - ntp
    - hosts
    - managed

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

  'cups.magevent.net':
    - cups
    - hosts
    - managed

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
