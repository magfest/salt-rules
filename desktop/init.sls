lxde:
  pkg.installed:
    - pkgs:
      - adwaita-gtk2-theme
      - adwaita-icon-theme
      - clipit
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

lxdm:
  service.running:
    - enable: True
    - require:
      - file: desktop
      - pkg: lxde

desktop:
  file.managed:
    - name: /etc/sysconfig/desktop
    - source:
      - salt://desktop/desktop
