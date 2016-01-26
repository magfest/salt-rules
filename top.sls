base:
  '*':
    - repos
    - managed
    - managed.update
    - login.ssh
    - login.admin
    - network.time
    - utils
  'cloudeins.magfest.net':
    - containers.sync
    - containers
    - network.bridge
  'cloudzwei.magfest.net':
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
