'gnome':
  yumpkg.group_install: []

gdm:
  service.running:
    - enable: True
