gnome-session:
  pkg.installed


gdm:
  pkg.installed
  service.running:
    - enable: True
    - require:
      - pkg: gnome-session
