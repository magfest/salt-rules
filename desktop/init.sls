lxde-desktop:
  yumpkg.group_installed

lxdm:
  service.running:
    - enable: True
    - require:
      - pkg: gnome-session
      - pkg: xorg-x11-server-Xorg
