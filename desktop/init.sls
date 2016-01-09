'gnome':
  pkg.group_install: []

gdm:
  service.running:
    - enable: True
