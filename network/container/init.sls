systemd-networkd:
  service.enabled

/etc/systemd/network:
  file.directory: []

/etc/systemd/network/host0.network:
  file.managed:
    - source: salt://network/container/host0.network
    - template: jinja
    - require:
      - file: /etc/systemd/network
