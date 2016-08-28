bind:
  pkg.installed: []

named:
  service.running:
    - enable: True
    - require:
      - file: /etc/named.conf
      - pkg: bind

/etc/named.conf:
  file.managed:
    - source: salt://dns/named.conf
    - template: jinja

/var/named:
  file.recurse:
    - source: salt://dns/zones
    - template: jinja
    - watch_in:
      - service: named
    - context:
      ignore_hosts: []
