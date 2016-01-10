lxde:
  module.run:
    - name: yumpkg.group_install
    - m_name: lxde-desktop

lxdm:
  service.running:
    - enable: True
    - require:
      - pkg: gnome-session
      - pkg: xorg-x11-server-Xorg
