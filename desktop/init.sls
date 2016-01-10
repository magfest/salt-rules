gnome-session:
  pkg.installed

gdm:
  service.running:
    - enable: True
    - require:
      - pkg: gnome-session
