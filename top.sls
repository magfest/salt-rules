base:
  'role:containerhost':
    - match: pillar
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - containers.sync
    - containers
    - network.bridge
    - selinux

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
    - network.container

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

  'role:asterisk':
    - match: pillar
    - asterisk

  'repo.magfe.st':
    - mrepo

  'role:dhcp-server':
    - match: pillar
    - dhcp

  'role:tftp-server':
    - match: pillar
    - tftp
    - container
    - tftp.foreman-proxy

  'foreman.magfe.st':
    - firewall
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
    - network.container

  'freeipa.magfe.st':
    - freeipa
