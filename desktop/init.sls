lxde-desktop:
  pkg.group_install

lxdm:
  service.running:
    - enable: True
    - require:
      - pkg: gnome-session
      - pkg: xorg-x11-server-Xorg
