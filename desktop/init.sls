'gnome':
  pkg.installed

gdm:
  service.running:
    - enable: True
