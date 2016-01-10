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
      - ghostscript
      - ghostscript-fonts
      - hplip
      - google-chrome-stable

lxdm:
  service.running:
    - enable: True
    - require:
      - file: desktop
      - file: /etc/lxdm/lxdm.conf
      - file: wallpaper
      - file: lxdeconf
      - pkg: lxde
    - watch:
      - file: /etc/lxdm/lxdm.conf

desktop:
  file.managed:
    - name: /etc/sysconfig/desktop
    - source:
      - salt://desktop/desktop

magfest:
  user.present:
    - fullname: MAGFest
    - shell: /usr/bin/bash
    - empty_password: True
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

lxdeconf:
  file.managed:
    - name: /home/magfest/.config/pcmanfm/LXDE/desktop-items-0.conf
    - source:
      - salt://desktop/desktop-items-0.conf
    - makedirs: True

/home/magfest:
  file.directory:
    - user: magfest
    - group: magfest
    - recurse:
      - user
      - group

/usr/share/lxdm/themes/Industrial/greeter.ui:
  file.managed:
    - source: salt://desktop/greeter.ui

/usr/share/icons/hicolor/128x128/apps/slack.png:
  file.managed:
    - source: salt://desktop/slack.png

/home/magfest/Desktop:
  file.recurse:
    - source: salt://desktop/Desktop
    - user: magfest
    - group: magfest
