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

  'salt.magfe.st':
    - managed.master
    - cloud
    - saltpad
    - hosts

  'asterisk.magfe.st':
    - asterisk

  'repo.magfe.st':
    - mrepo
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

  'tftp.magfe.st':
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

  'foreman.magfe.st':
    - firewall
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - hosts

  'freeipa.magfe.st':
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

  'ntp*.magfe.st':
    - ntp
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

  'freeradius.magfe.st':
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

  'cups.magfe.st':
    - cups
    - hosts

  'noc.magfe.st':
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

  'assman.magfe.st':
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
