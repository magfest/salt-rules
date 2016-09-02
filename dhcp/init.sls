dhcp:
  pkg.installed: []

dhcpd:
  service.running:
    - enable: True
    - require:
      - pkg: dhcp
      - file: /etc/dhcp/dhcpd.conf

/etc/dhcp/dhcpd.conf:
  file.managed:
    - source: salt://dhcp/dhcpd.conf
    - template: jinja
    - watch_in:
      - serviec: dhcpd
