# Uncomment to enable auto-generation of magic (e.g. labs sytle) backgrounds
#include:
#  - desktop.wallpaper

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
      - gnome-screenshot
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
      - xscreensaver-base
      - xscreensaver-extras
      - xscreensaver-gl-base
      - xscreensaver-gl-extras
      - yumex-dnf
      - xorg-x11-drv-evdev
      - ghostscript
      - ghostscript-fonts
      - hplip
      - google-chrome-stable
      - words
      - iwl3945-firmware
      - iwl5000-firmware
      - iwl5150-firmware
xpad:
  pkg.removed

lxdm:
  service.enabled:
    - require:
      - file: desktop
      - file: /etc/lxdm/lxdm.conf
# Uncomment for labs BG
###############################
#      - sls: desktop.wallpaper
###############################
# Comment for labs BG
      - file: wallpaper
###############################
      - file: lxdeconf
      - pkg: lxde
    - watch:
      - file: /etc/lxdm/lxdm.conf

/etc/systemd/system/multi-user.target.wants/display-manager.service:
  file.symlink:
    - target: ../display-manager.service
    

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

# This can stay actually, might as well keep it...
wallpaper:
  file.managed:
    - name: /usr/share/backgrounds/magfest.jpg
    - source: salt://desktop/magfest.jpg

lxdm.conf:
  file.managed:
    - name: /etc/lxdm/lxdm.conf
    - require:
      - pkg: lxde
    - makedirs: True
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
    - require:
      - pkg: lxde
    - makedirs: True

/usr/share/icons/hicolor/128x128/apps/slack.png:
  file.managed:
    - source: salt://desktop/slack.png

/usr/share/icons/hicolor/128x128/apps/uber.png:
  file.managed:
    - source: salt://desktop/uber.png

/home/magfest/Desktop:
  file.recurse:
    - source: salt://desktop/Desktop
    - user: magfest
    - group: magfest

/usr/bin/magname:
  file.managed:
    - source: salt://desktop/magname
    - mode: '755'

/home/magfest/.xscreensaver:
  file.managed:
    - source: salt://desktop/xscreensaver
    - require:
      - file: /usr/bin/magname

/usr/lib/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js:
  file.managed:
    - source: salt://desktop/prefs.js
    - makedirs: True
