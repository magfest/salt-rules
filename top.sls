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
    - containers
    - network.bridge
  'cloudzwei.magfest.net':
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
