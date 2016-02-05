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

  'repo.magfe.st':
    - mrepo

  'foreman.magfe.st':
    - foreman

  'freeipa.magfe.st':
    - freeipa
