base:
  '*':
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
  'role:containerhost':
    - match: pillar
    - containers.sync
    - containers
    - network.bridge
  'laptop.magfest.net':
    - desktop
    - desktop.utilities
    - desktop.admins
    - extlinux
    - graphics
    - kiosk
    - challenges
    - selinux
    - challenges.emulators
