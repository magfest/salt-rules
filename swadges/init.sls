swadge-router-prereqs:
  pkg.installed:
    - pkgs:
      - libuv
      - jansson
      - python34
      - python34-devel
      - redhat-rpm-config
      - python34-pip
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
    - bin_env: /bin/pip3
    - require:
      - pkg: swadge-router-prereqs
  service.running:
    - enable: True
    - require:
      - file: /usr/lib/systemd/system/crossbar.service
