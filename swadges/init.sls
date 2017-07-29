swadge-router-prereqs:
  pkg.installed:
    - pkgs:
      - libuv
      - jansson
      - python3
      - python3-devel
      - redhat-rpm-config
      - python3-pip
      - gcc

/etc/crossbar.json:
  file.managed:
    - source: salt://swadges/config.json
    - template: jinja

/usr/lib/systemd/system/crossbar.service:
  file.managed:
    - source: salt://swadges/crossbar.service

crossbar:
  pip_state.installed:
    - require:
      - pkg: swadge-router-prereqs
  service.running:
    - enable: True
    - require:
      - file: /usr/lib/systemd/system/crossbar.service
