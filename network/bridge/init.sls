systemd-networkd:
  service.running:
    - enable: True
    - watch:
      - file: /etc/systemd/network/*

/etc/systemd/network:
  file.directory: []

/etc/systemd/network/br0.netdev:
  file.managed:
    - source: salt://network/bridge/br0.netdev
    - template: jinja
    - require:
      - file: /etc/systemd/network

/etc/systemd/network/br0.network:
  file.managed:
    - source: salt://network/bridge/br0.network
    - template: jinja
    - require:
      - file: /etc/systemd/network

/etc/systemd/network/{{ pillar['network'][grains['host']]['containerdev'] }}.netdev:
  file.managed:
    - source: salt://network/bridge/eth.netdev
    - template: jinja
    - require:
      - file: /etc/systemd/network

/etc/systemd/network/{{ pillar['network'][grains['host']]['containerdev'] }}.network:
  file.managed:
    - source: salt://network/bridge/eth.network
    - template: jinja
    - require:
      - file: /etc/systemd/network
