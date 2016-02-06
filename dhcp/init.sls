dhcp-server:
  pkg.installed: []

dhcpd:
  service.running:
    - enable: True
    - require:
      - pkg: dhcp-server
      - file: /etc/dhcp/dhcpd.conf

/etc/dhcp/dhcpd.conf:
  file.managed:
    - source: salt://dhcp/dhcpd.conf
    - template: jinja

