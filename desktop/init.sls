'gnome':
  pkg.group_installed

gdm:
  service.running:
    - enable: True
