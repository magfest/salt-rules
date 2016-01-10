lxde:
  pkg.installed:
    - pkgs:
      - mlocate
      - system-config-printer
      - firefox
      - bind-utils
      - tcpdump
      - traceroute
      - p7zip
      - caja
      - atril
      - pluma
      - rxvt
      - ipw2100-firmware
      - ipw2200-firmware
      - libreoffice

cups:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: cups
