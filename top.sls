base:
  '*':
    - managed
    - managed.update
    - repos
    - login.ssh
    - login.admin
    - network.time
  'laptop.magfest.net':
    - desktop
    - desktop.utilities
