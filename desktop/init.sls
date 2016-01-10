gnome-session:
  pkg.installed

xorg-x11-server-Xorg:
  pkg.installed

gdm:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: gnome-session
      - pkg: xorg-x11-server-Xorg
