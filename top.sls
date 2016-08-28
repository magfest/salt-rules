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

  'salt.magfe.st':
    - managed.master
    - cloud
    - saltpad

  'asterisk.magfe.st':
    - asterisk

  'repo.magfe.st':
    - mrepo

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

  'role:tftp-server':
    - match: pillar
    - tftp
    - tftp.foreman-proxy

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
    - tftp.foreman-proxy
    - voip-provision
    - ftp

  'foreman.magfe.st':
    - firewall
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils

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

  'ntp*.magfe.st':
    - ntp

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

  'cups.magfe.st':
    - cups

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
