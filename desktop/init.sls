lxde:
  pkg.installed:
    - pkgs:
      - adwaita-gtk2-theme
      - adwaita-icon-theme
      - fedora-icon-theme
      - firewall-config
      - galculator
      - gigolo
      - gnome-keyring-pam
      - gpicview
      - initial-setup-gui
      - leafpad
      - lxappearance
      - lxappearance-obconf
      - lxde-common
      - lxdm
      - lxinput
      - lxlauncher
      - lxmenu-data
      - lxpanel
      - lxpolkit
      - lxrandr
      - lxsession
      - lxsession-edit
      - lxtask
      - lxterminal
      - network-manager-applet
      - nm-connection-editor
      - notification-daemon
      - obconf
      - openbox
      - openssh-askpass
      - pcmanfm
      - perl-File-MimeInfo
      - upower
      - xarchiver
      - xcompmgr
      - xdg-user-dirs-gtk
      - xpad
      - xscreensaver-base
      - xscreensaver-extras
      - yumex
      - xorg-x11-drv-evdev

lxdm:
  service.running:
    - enable: True
    - require:
      - file:
        - desktop
        - /etc/lxdm/lxdm.conf
        - wallpaper
      - pkg: lxde
    - watch:
      - file:
        - /etc/lxdm/lxdm.conf
        - wallpaper

desktop:
  file.managed:
    - name: /etc/sysconfig/desktop
    - source:
      - salt://desktop/desktop

magfest:
  user.present:
    - fullname: MAGFest
    - shell: /usr/bin/bash
    - home: /home/magfest
    - groups:

wallpaper:
  file.managed:
    - name: /usr/share/backgrounds/magfest.png
    - source:
      - salt://desktop/magfest.png

lxdm.conf:
  file.managed:
    - name: /etc/lxdm/lxdm.conf
    - source:
      - salt://desktop/lxdm.conf
